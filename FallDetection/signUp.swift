//
//  signUp.swift
//  FallDetection
//
//  Created by Abel Weldareguy on 7/2/18.
//  Copyright © 2018 Abel Weldaregay. All rights reserved.
//

import UIKit
import Alamofire

class signUp: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var emeContact: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var roleDropDown: UIPickerView!
    
    @IBOutlet weak var serProviderDropDown: UIPickerView!
    @IBOutlet weak var serviceProvider: UITextField!
    @IBOutlet weak var roleInputField: UITextField!
    var firstNameInput = "empty"
    var lastNameInput = "empty"
    var usernameInput = "empty"
    var passwordInput = "empty"
    var emecontactInput = "empty"
    var roleInput = "empty"
    var serviceProviderInput = "empty"
    var deviceID = UIDevice.current.identifierForVendor!.uuidString
    let roles = ["Admin", "Patient"]
    let serviceProviders = ["Verizon", "T-Mobile", "AT&T", "Sprint"]
   
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        var countRow : Int = roles.count
        
        if pickerView == roleDropDown
        {
            countRow = self.roles.count
        }
        
        if pickerView == serProviderDropDown
        {
            countRow = self.serviceProviders.count
        }
        
        return countRow
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == roleDropDown
        {
             return roles[row]
        }
        
        else if pickerView == serProviderDropDown
        {
            return serviceProviders[row]
        }
        
        return "pickerView crash"
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == roleDropDown
        {
            self.roleInputField.text = roles[row]
            //self.roleDropDown.isHidden = true
        }
        else if pickerView == serProviderDropDown
        {
            self.serviceProvider.text = serviceProviders[row]
           // self.serProviderDropDown.isHidden = true
        }
     
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == roleInputField
        {
            self.roleDropDown.isHidden = false
            roleInputField.resignFirstResponder()
            
        }
        
        if textField == serviceProvider
        {
            self.serProviderDropDown.isHidden = false
            serviceProvider.resignFirstResponder()
        }
        
    }
    
    
    var formValid = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let backItem = UIBarButtonItem()
        backItem.title = "Sign-In"
        navigationItem.backBarButtonItem = backItem
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        view.endEditing(true)
        
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        
        firstName.resignFirstResponder()
        lastName.resignFirstResponder()
        serviceProvider.resignFirstResponder()
        emeContact.resignFirstResponder()
        username.resignFirstResponder()
        password.resignFirstResponder()
        roleInputField.resignFirstResponder()
    }
    
    func displayAlertMessage(message: String) {
        let alertMsg = UIAlertController(title:"Alert", message: message,
                                         preferredStyle:UIAlertControllerStyle.alert);
        
        let confirmAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil );
        alertMsg.addAction(confirmAction)
        present(alertMsg, animated:true, completion: nil)
    }
 
    @IBAction func createAccountPressed(_ sender: UIButton) {
        
        if (emeContact.text?.isEmpty)! || (username.text?.isEmpty)! || (password.text?.isEmpty)! || (roleInputField.text?.isEmpty)! || (firstName.text?.isEmpty)! || (lastName.text?.isEmpty)! || (emeContact.text?.isEmpty)! || (serviceProvider.text?.isEmpty)!
   {
        displayAlertMessage(message: "All fields are required.")
   }
    else
   {
        self.usernameInput = username.text!
        self.passwordInput = password.text!
        self.emecontactInput = emeContact.text!
        self.firstNameInput = firstName.text!
        self.lastNameInput = lastName.text!
    
    switch self.serviceProvider.text! {
        
    case "Verizon":
        self.serviceProviderInput = "vtext.com"
    case "Sprint":
        self.serviceProviderInput = "messaging.sprintcs.com"
    case "T-Mobile":
        self.serviceProviderInput = "tmomail.net"
    case "AT&T":
        self.serviceProviderInput = "txt.att.net"
        
    default:
        "empty service provider"
    }
    
    
    
        if roleInputField.text! == "Patient"
        {
            self.roleInput = "2"
            self.writeToDataBase()
            self.displayAlertMessage(message: "You have been successfully added to the database!")
            username.text! = ""
            password.text! = ""
            emeContact.text! = ""
            roleInputField.text! = ""
            performSegue(withIdentifier: "toViewController",
                         sender: self)
            
        }
        else
        {
            self.roleInput = "1"
            self.writeToDataBase()
            self.displayAlertMessage(message: "You have been successfully added to the database!")
            username.text! = ""
            password.text! = ""
            emeContact.text! = ""
            roleInputField.text! = ""
            performSegue(withIdentifier: "toViewController",
                         sender: self)
        
        }
    
    }
    

   }
  
    
    func writeToDataBase(){
        
        let url = URL(string: "http://qav2.cs.odu.edu/abel/FallDetectionScripts/signUp/signUp.php")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
       

        let postString = "username=\(self.usernameInput)&password=\(self.passwordInput)&emecontact=\(self.emecontactInput)&role=\(self.roleInput)&deviceID=\(self.deviceID)&firstname=\(self.firstNameInput)&lastname=\(self.lastNameInput)&serviceProvider=\(self.serviceProviderInput)"
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
            print("responseString = \(responseString)")
        }
        task.resume()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
