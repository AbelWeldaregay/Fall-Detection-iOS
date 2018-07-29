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

class LoggedIn: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var detectionStatus: UILabel!
    
    @IBOutlet weak var switchButton: UISwitch!
    
    @IBOutlet weak var userData: UIView!
    
    @IBOutlet weak var logOutButton: UIButton!
    
    @IBOutlet weak var usernameIcon: UILabel!
    
    @IBOutlet weak var roleIcon: UILabel!
    
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
         self.navigationItem.setHidesBackButton(true, animated: true)
         self.title = "Fall Detection"
            switchButton.isOn = false
        userData.isHidden = true
        // Do any additional setup after loading the view.
        
        usernameIcon.text = uname
        roleIcon.text = role
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
          
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
                
                if let myData = data
                {
                    self.accelX.text = "Accel-X: " + String(format: "%.2f" , myData.acceleration.x)
                    self.accelY.text = "Accel-Y: " + String(format: "%.2f" , myData.acceleration.y)
                    self.accelZ.text = "Accel-Z: " + String(format: "%.2f" , myData.acceleration.z)
                    
                    if  (abs(myData.acceleration.x) + abs(myData.acceleration.y) + abs(myData.acceleration.z)) >= 4
                    {
                        print ((abs(myData.acceleration.x) + abs(myData.acceleration.y) + abs(myData.acceleration.z)))
                        self.motionManager.stopAccelerometerUpdates()
                        self.motionManager.stopGyroUpdates()
                        self.redirecttoLoggedInView()
                        
                    }
                    
                }
                
            } //end of motionmanager.startAcc
           
            
            motionManager.startGyroUpdates(to: OperationQueue.current!) { (data, error) in
                
                if let myDataGyro = data
                {
                    self.gyroX.text = "Gyro-X: " + String(format: "%.2f" , myDataGyro.rotationRate.x)
                    self.gyroY.text = "Gyro-Y: " + String(format: "%.2f" ,  myDataGyro.rotationRate.y)
                    self.gyroZ.text = "Gyro-Z: " + String(format: "%.2f" , myDataGyro.rotationRate.z)

                }
                
            } //end of motionmanager.startAcc
            
            
            
        }
        else if (sender.isOn == false){
            userData.isHidden = true
            logOutButton.isHidden = false
            motionManager.stopAccelerometerUpdates()
            detectionStatus.text = "Detection Status: OFF"
        }
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
