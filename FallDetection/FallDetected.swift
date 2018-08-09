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
    
    var player: AVAudioPlayer?
    
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
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "zapsplat_emergency_alarm_siren", withExtension: "mp3") else {
            print("url not found")
            return
        }
        
        do {
            /// this codes for making this app ready to takeover the device audio
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /// change fileTypeHint according to the type of your audio file (you can omit this)
            
            /// for iOS 11 onward, use :
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /// else :
            /// player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3)
            
            // no need for prepareToPlay because prepareToPlay is happen automatically when calling play()
            player!.play()
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
        }
    }

    @objc func runTimedCode() {
        
//        AudioServicesPlaySystemSoundWithCompletion(kSystemSoundID_Vibrate) {
//            // do what you'd like now that the sound has completed playing
//            AudioServicesPlaySystemSound(1103)
//
//        }
        playSound()
        counterLabel.text = "\(counter)"
        counter -= 1

        if (counter == 0)
        {
            player?.stop()
            //send the email to eme contact
            counterTimer.invalidate()
            sendEmail()
            
        }
        
    }
    
    @IBAction func iAmOkayPressed(_ sender: Any) {
        
        player?.stop()
        
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
