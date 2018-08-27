//
//  ModifyView.swift
//  FallDetection
//
//  Created by Abel Weldareguy on 8/19/18.
//  Copyright © 2018 Abel Weldaregay. All rights reserved.
//

import UIKit
var myIndex = 0

class ModifyView: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var list = ["First Name", "Last Name", "Username", "Emergency Contact", "password", "rolename"]
    var oldPassord = "empty"
    var newPassword = "empty"
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        list[0] = "First Name: " + firstName
        list[1] = "Last Name : " + lastName
        list[2] = "Username  : " + uname
        list[3] = "Emerg Cont: " + emeContact
        list[4] = "Password  : " + "*****"
        list[5] = "Role Name : " + role
       
        
    }
    
    func updateDataBase(oldValue: String, newValue : String, updateField: String){
        
        let url = URL(string: "http://qav2.cs.odu.edu/abel/FallDetectionScripts/updateUserInfo.php")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        
        
        let postString = "oldValue=\(oldValue)&newValue=\(newValue)&updateField=\(updateField)"
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
    
    
    func showInputDialog() {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Alert", message: "Enter Password details", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            
            //getting the input values from user
            self.oldPassord = (alertController.textFields?[0].text)!
            self.newPassword = (alertController.textFields?[1].text)!
            
                
            if pass != self.oldPassord
            {
                self.displayAlertMessage(message: "Old password does not match our record. Please try again.")
            }
            else if pass == self.newPassword
            {
                self.displayAlertMessage(message: "Old password and new password cannot be the same. Please try again.")
            }
            else
            {
                self.updateDataBase(oldValue: self.oldPassord, newValue: self.newPassword, updateField: "password")
                self.displayAlertMessage(message: "Password updated successfully.")
            }
          
            
        }
        
        //the cancel action doing nothing
        // let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = "Old Password"
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "New Password"
            
        }
        
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        //alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func updateUserInfo(updateField : String)
    {
 
        if updateField == "Password"
        {
            self.showInputDialog()
            
        }
        else
        {
            let alert = UIAlertController(title: updateField, message: "Please enter the new \(updateField)", preferredStyle: UIAlertControllerStyle.alert)
            
            let action = UIAlertAction(title: "Update", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
                
            let answer = alert.textFields![0].text as! String
            
                switch updateField {
                case "firstName":
                    self.updateDataBase(oldValue: firstName, newValue: answer, updateField: updateField)
                    self.list[0] = "First Name : " + answer
                case "lastName":
                    self.updateDataBase(oldValue: lastName, newValue: answer, updateField: updateField)
                    self.list[1] = "Last Name  : " + answer
                case "userName":
                    self.updateDataBase(oldValue: uname, newValue: answer, updateField: updateField)
                     self.list[2] = "Username  : " + answer
                case "EmergencyContact":
                    self.updateDataBase(oldValue: emeContact, newValue: answer, updateField: "emgycontact")
                    self.list[3] = "Emerg Cont : " + answer
                
                default:
                    print ("noting selected")
                }
            
        
            
                
            }
            
            alert.addTextField { (textField) in
                textField.placeholder = "Enter new first Name"
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
            
        }
        
        
    } //end of update user info
    
    

    
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
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        myIndex = indexPath.row
        
        switch myIndex {
        case 0:
            self.updateUserInfo(updateField: "firstName")
        case 1:
            self.updateUserInfo(updateField: "LastName")
        case 2:
            self.updateUserInfo(updateField: "userName")
        case 3:
             self.updateUserInfo(updateField: "EmergencyContact")
        case 4:
             self.updateUserInfo(updateField: "Password")
        case 5:
             self.updateUserInfo(updateField: "roleName")
        default:
            displayAlertMessage(message: "nothing")
        }
        
   
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return(list.count)
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celltwo = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "celltwo")
            celltwo.textLabel?.text = list[indexPath.row]
           celltwo.accessoryType = .disclosureIndicator
        return (celltwo)
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {1
        
        cell.contentView.backgroundColor = UIColor.white
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }



}
