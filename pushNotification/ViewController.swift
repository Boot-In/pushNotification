//
//  ViewController.swift
//  pushNotification
//
//  Created by macbook on 09.08.2022.
//

import UIKit

class ViewController: UIViewController {

    let notifications = Notifications()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    
    @IBAction func myButtonAction(_ sender: UIButton) {
        notifications.showNotification(notificationTitle: "proverka", time: 5)
        
    }
    
    
    
}

