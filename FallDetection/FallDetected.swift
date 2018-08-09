//
//  FallDetected.swift
//  FallDetection
//
//  Created by Abel Weldareguy on 6/7/18.
//  Copyright © 2018 Abel Weldaregay. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class FallDetected: UIViewController {

    @IBOutlet weak var counterLabel: UILabel!
    var counter = 10
    var counterTimer : Timer!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        // Do any additional setup after loading the view.
        counterTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        
     
       
        //AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))

        
        
        
    }
    
    func redirecttoLoggedInView(){
        let storyBoard = UIStoryboard(name: "FallDetected", bundle: nil)
        let secondVC = storyBoard.instantiateViewController(withIdentifier: "loggedIn") as! LoggedIn
        self.navigationController?.pushViewController(secondVC, animated: true)
    }

    @objc func runTimedCode() {
        
        AudioServicesPlaySystemSoundWithCompletion(kSystemSoundID_Vibrate) {
            // do what you'd like now that the sound has completed playing
            AudioServicesPlaySystemSound(1304)
            
        }
        
        counterLabel.text = "\(counter)"
        counter -= 1

        if (counter == 0)
        {
            //send the email to eme contact
            counterTimer.invalidate()
            sendEmail()
            
        }
        
    }
    
    @IBAction func iAmOkayPressed(_ sender: Any) {
        counterTimer.invalidate()
        
        //self.redirecttoLoggedInView()
    }
    
    
    func sendEmail(){
        
        let url = URL(string: "http://qav2.cs.odu.edu/abel/FallDetectionScripts/sendEmail/sendEmail.php")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        
        
        let postString = "firstname=\(firstName)&lastname=\(lastName)&phoneNumber=\(emeContact)&serviceProvider=\(serviceProvider)"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
        }
        task.resume()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
