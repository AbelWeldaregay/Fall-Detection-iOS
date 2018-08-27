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
    
    
    func updateUserInfo(updateField : String)
    {
 
        if updateField == "password"
        {
            
            let alert = UIAlertController(title: "Password", message: "", preferredStyle: UIAlertControllerStyle.alert)
            
            let action = UIAlertAction(title: "Update", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            let textField2 = alert.textFields![1] as UITextField
            
            let oldPassword = alert.textFields![0].text as! String
            let newPassword = alert.textFields![1].text as! String
            
            self.updateDataBase(oldValue: oldPassword, newValue: newPassword, updateField: updateField)
          
            }
            
            alert.addTextField { (textField) in
                textField.placeholder = "Enter old Password"
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
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
                    self.list[0] = "First Name: " + answer
                case "lastName":
                    self.updateDataBase(oldValue: lastName, newValue: answer, updateField: updateField)
                    self.list[1] = "Last Name : " + answer
                case "userName":
                    self.updateDataBase(oldValue: uname, newValue: answer, updateField: updateField)
                     self.list[2] = "Username  : " + answer
                case "EmergencyContact":
                    self.updateDataBase(oldValue: emeContact, newValue: answer, updateField: "emgycontact")
                    self.list[3] = "Emerg Cont: " + answer
        
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
