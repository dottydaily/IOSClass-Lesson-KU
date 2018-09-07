//
//  ViewController.swift
//  Keyboard
//
//  Created by iOS Dev on 9/6/2561 BE.
//  Copyright © 2561 iOS Dev. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITextFieldDelegate /*<<-- this is protocol*/{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.textField.addTarget(nil, action: Selector(("dummy")), for: .editingDidEndOnExit)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func doneTouchUp(_ sender: Any) {
        self.textField.resignFirstResponder()
        self.textView.resignFirstResponder()
    }
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textField: UITextField!
    
    // hide keyboard when return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        return true
    }
    
    
}

