//
//  ViewController.swift
//  ViewChange
//
//  Created by iOS Dev on 8/30/2561 BE.
//  Copyright © 2561 iOS Dev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextButtonToPage2() {
        performSegue(withIdentifier: "Page1ToPage2", sender: self)
    }
    
    @IBAction func backToPage1(seg:UIStoryboardSegue!) {
    
    }
}

