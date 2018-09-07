//
//  Page2ViewController.swift
//  ViewChange
//
//  Created by iOS Dev on 8/31/2561 BE.
//  Copyright © 2561 iOS Dev. All rights reserved.
//

import UIKit

class Page2ViewController: UIViewController {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBAction func nextToPage3(_ sender: Any) {
        performSegue(withIdentifier: "Page2ToPage3", sender: self)
    }
    
    @IBAction func backToPage2(seg:UIStoryboardSegue!) {
    }
}
