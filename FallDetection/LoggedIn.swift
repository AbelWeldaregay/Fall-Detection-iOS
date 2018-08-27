//
//  LoggedIn.swift
//  FallDetection
//
//  Created by Abel Weldareguy on 6/3/18.
//  Copyright © 2018 Abel Weldaregay. All rights reserved.
//

import UIKit
import CoreMotion
import CoreLocation

class LoggedIn: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var detectionStatus: UILabel!
    
    @IBOutlet weak var switchButton: UISwitch!
    
    @IBOutlet weak var userData: UIView!
    
    @IBOutlet weak var logOutButton: UIButton!
    
    @IBOutlet weak var roundedCornerButton: UIButton!
    
    @IBOutlet weak var welcomeBar: UILabel!
    
    @IBOutlet weak var iAmOkayLabel: UILabel!
    
    @IBOutlet weak var iAmOkayButton: UIButton!
    
    var list = ["temp1", "temp2","temp3", "temp4"]
    
    var counter = 10
    var counterTimer : Timer!
    var iAmOkayIndicator = false
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return(list.count)
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = list[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.contentView.backgroundColor = UIColor.black
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    //*****acceleration labels****************
    @IBOutlet weak var accelX: UILabel!
    @IBOutlet weak var accelY: UILabel!
    @IBOutlet weak var accelZ: UILabel!
    
    //*******Gyro labels ********************
    
    @IBOutlet weak var gyroX: UILabel!
    @IBOutlet weak var gyroY: UILabel!
    @IBOutlet weak var gyroZ: UILabel!
    
    
    
    var motionManager = CMMotionManager()
    let locationManager : CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.switchButton.isHidden = false
        
         self.navigationItem.setHidesBackButton(true, animated: true)
         self.title = "Fall Detection"
        
            switchButton.isOn = false
        userData.isHidden = true
        roundedCornerButton.layer.cornerRadius = 4
        welcomeBar.text = "Welcome " + firstName + "!"
        // Do any additional setup after loading the view.
        
        list[0] = "First Name: " + firstName
        list[1] = "Last Name : " + lastName
        list[2] = "Role      : " + role
        list[3] = "Status    : Normal"
        
        iAmOkayLabel.isHidden = true
        iAmOkayButton.isHidden = true
        iAmOkayButton.layer.cornerRadius = 5
        iAmOkayButton.layer.borderWidth = 1
        iAmOkayButton.layer.borderColor = UIColor.black.cgColor
        counter = 10
        
        self.iAmOkayIndicator = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func redirecttoLoggedInView(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyBoard.instantiateViewController(withIdentifier: "FallDetected") as! FallDetected
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    @objc func runTimedCode() {
        
        self.iAmOkayIndicator = true
       
    
            iAmOkayLabel.text = "\(counter)"
            counter = counter - 1
            
            if (counter == 0)
            {
                self.counter = 10
                self.iAmOkayIndicator = false
                
                //push to fall detected view
                counterTimer.invalidate()
                self.redirecttoLoggedInView()
            }
  
        
        
    }
    
    func updateAccAndGyro(){
        
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            
            if let myData = data
            {
                self.accelX.text = "Accel-X: " + String(format: "%.2f" , myData.acceleration.x)
                self.accelY.text = "Accel-Y: " + String(format: "%.2f" , myData.acceleration.y)
                self.accelZ.text = "Accel-Z: " + String(format: "%.2f" , myData.acceleration.z)
                
                if  (abs(myData.acceleration.x) + abs(myData.acceleration.y) + abs(myData.acceleration.z)) >= 4.0
                {
                    self.switchButton.isHidden = true
                    
                    print ((abs(myData.acceleration.x) + abs(myData.acceleration.y) + abs(myData.acceleration.z)))
                    self.motionManager.stopAccelerometerUpdates()
                    self.motionManager.stopGyroUpdates()
                    
                    self.userData.isHidden = true
                    
                    self.iAmOkayLabel.isHidden = false
                    self.iAmOkayButton.isHidden = false
                    
                    //start the warning timer before confirming a fall
                    self.counterTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.runTimedCode), userInfo: nil, repeats: true)
                    //self.redirecttoLoggedInView()
                    
                }
                
            }
            
        }//end of motionmanager.startAcc
        
        motionManager.startGyroUpdates(to: OperationQueue.current!) { (data, error) in
            
            if let myDataGyro = data
            {
                self.gyroX.text = "Gyro-X: " + String(format: "%.2f" , myDataGyro.rotationRate.x)
                self.gyroY.text = "Gyro-Y: " + String(format: "%.2f" ,  myDataGyro.rotationRate.y)
                self.gyroZ.text = "Gyro-Z: " + String(format: "%.2f" , myDataGyro.rotationRate.z)
                
            }
            
        } //end of motionmanager.startAcc
        
        
        
        
    }
        
    @IBAction func `switch`(_ sender: UISwitch) {
        
        if(sender.isOn == true)
        {
            
            logOutButton.isHidden = true
            
            detectionStatus.text = "Detection Status: ON"
            userData.isHidden = false
            motionManager.accelerometerUpdateInterval = 0.025
            motionManager.gyroUpdateInterval = 0.2
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
          
            
            if self.iAmOkayIndicator == false
            {
                self.counter = 10
                self.updateAccAndGyro()
            }
            
            
        }
        else if (sender.isOn == false){
            userData.isHidden = true
            logOutButton.isHidden = false
            iAmOkayButton.isHidden = true
            iAmOkayLabel.isHidden = true
            motionManager.stopAccelerometerUpdates()
            
            detectionStatus.text = "Detection Status: OFF"
        }
    }
    
 
    
  
    @IBAction func iAmOkayPressed(_ sender: Any) {
        self.iAmOkayLabel.text = "10"
        self.counter = 10
        self.switchButton.isHidden = false
        iAmOkayIndicator = false
        counterTimer.invalidate()
        iAmOkayButton.isHidden = true
        iAmOkayLabel.isHidden = true
        userData.isHidden = false
       
        self.updateAccAndGyro()
        
    }
    
    @IBAction func logoutPressed(_ sender: UIButton) {
        
        print ("logout pressed")
        motionManager.stopAccelerometerUpdates()
        motionManager.stopGyroUpdates()
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       
        for currentLocation in locations
        {
                 print ("\(index): \(currentLocation)")
        }
        
       
    }

   

}
