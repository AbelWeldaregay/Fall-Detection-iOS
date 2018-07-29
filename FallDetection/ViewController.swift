//
//  ViewController.swift
//  FallDetection
//
//  Created by Abel Weldareguy on 6/3/18.
//  Copyright © 2018 Abel Weldaregay. All rights reserved.
//

import UIKit
import Alamofire
import AVFoundation
import AudioToolbox

var uname = "empty"
var role = "empty"
var emeContact = "empty"

class ViewController: UIViewController {

    @IBOutlet weak var usernameInput: UITextField!
    
    @IBOutlet weak var passwordInput: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //*****************************
        let backItem = UIBarButtonItem()
        backItem.title = "Sign-In"
        backItem.tintColor = UIColor.white
        
        navigationItem.backBarButtonItem = backItem
        //*****************************
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        navigationController?.navigationBar.barTintColor = UIColor.red
        //setting the shape of the buttons
        loginButton.layer.cornerRadius = 8.0
        signUpButton.layer.cornerRadius = 8.0
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        
        usernameInput.resignFirstResponder()
        passwordInput.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayAlertMessage(message: String) {
        let alertMsg = UIAlertController(title:"Alert", message: message,
                                         preferredStyle:UIAlertControllerStyle.alert);
        
        let confirmAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil );
        alertMsg.addAction(confirmAction)
        present(alertMsg, animated:true, completion: nil)
    }
    
    func redirecttoLoggedInView(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyBoard.instantiateViewController(withIdentifier: "LoggedIn") as! LoggedIn
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        var username = usernameInput.text!
        let password = passwordInput.text!
        
        if((username.isEmpty) || (password.isEmpty))
        {
             AudioServicesPlayAlertSound(SystemSoundID(4095))
            self.displayAlertMessage(message: "All fields required.")
        }
        else
        {
            //alamofire request
            Alamofire.request("http://qav2.cs.odu.edu/abel/FallDetectionScripts/signUp/login.php?username=\(username)&password=\(password)").responseJSON{ response in
                print (response)
                
                if let userJson = response.result.value {
                    
                    let userObject:Dictionary = userJson as! Dictionary<String, Any>
                    uname = userObject["username"] as! String
                    role = userObject["role_id"] as! String
                    emeContact = userObject["emgycontact"] as! String
                    if role == "1"
                    {
                        role = "Admin"
                    }
                    else if role == "2"
                    {
                        role = "Patient"
                    }
//                    correctName = userObject["name"] as! String
//                    userRole = userObject["role"] as! String
//                    userDescription = userObject["description"] as! String
                    
                    self.redirecttoLoggedInView()
                    //self.performSegue(withIdentifier: "Segue", sender: self)
                    
                    
                }
                else {
                    self.displayAlertMessage(message: "Wrong Credentials, Please try again.")
                    return
                }
                
                
                
            }
            
            
        }
        
        
    }
    
    
    
    
    
    


}

