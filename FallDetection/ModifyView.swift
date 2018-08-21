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

    var list = ["First Name", "Last Name", "Username", "password", "rolename"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        list[0] = "First Name:    " + firstName
        list[1] = "Last Name :    " + lastName
        list[2] = "Username  :    " + uname
        list[3] = "Role Name :    " + role
        list[4] = "Password  :    " + "*****"
        
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
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        myIndex = indexPath.row
        
        switch myIndex {
        case 0:
            displayAlertMessage(message: "First Name")
        case 1:
            displayAlertMessage(message: "Last Name")
        case 2:
            displayAlertMessage(message: "username")
        case 3:
            displayAlertMessage(message: "role")
        case 4:
            displayAlertMessage(message: "Password")
            
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.contentView.backgroundColor = UIColor.white
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }



}
