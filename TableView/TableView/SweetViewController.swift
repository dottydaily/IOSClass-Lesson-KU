//
//  SweetViewController.swift
//  TableView
//
//  Created by iOS Dev on 9/14/2561 BE.
//  Copyright © 2561 iOS Dev. All rights reserved.
//

import UIKit

class SweetViewController: UIViewController {
    public var sweetText:String!

    @IBOutlet weak var dataLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.dataLabel.text = sweetText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
