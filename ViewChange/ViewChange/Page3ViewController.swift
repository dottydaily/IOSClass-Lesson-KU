//
//  Page3ViewController.swift
//  ViewChange
//
//  Created by iOS Dev on 8/31/2561 BE.
//  Copyright © 2561 iOS Dev. All rights reserved.
//

import UIKit

class Page3ViewController: UIViewController {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBAction func backToPage1TouchUp(_ sender: Any) {
        performSegue(withIdentifier: "Page3ToPage1", sender: self)
    }
}
