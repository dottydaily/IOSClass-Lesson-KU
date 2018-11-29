//
//  ViewController.swift
//  MapMultiLanguage
//
//  Created by iOS Dev on 15/11/2561 BE.
//  Copyright © 2561 iOS Dev. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .denied, .notDetermined, .restricted :
                let alert = UIAlertController(
                    title: NSLocalizedString("Cannot Access Location", comment: "") ,
                    message: NSLocalizedString("Please allow the App to access location service.", comment: "") ,
                    preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Yeah", comment: ""),
                                              style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                break
                
            case .authorizedAlways :
                break
            case .authorizedWhenInUse :
                break
            }
        }
        else {
            let alert = UIAlertController(
                title: NSLocalizedString("Cannot Access Location", comment: "") ,
                message: NSLocalizedString("Please allow the App to access location service.", comment: "") ,
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Yeah", comment: ""),
                                          style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

}

