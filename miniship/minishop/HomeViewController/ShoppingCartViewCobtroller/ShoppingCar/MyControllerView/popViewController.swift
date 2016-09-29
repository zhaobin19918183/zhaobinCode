//
//  popViewController.swift
//  minishop
//
//  Created by Zhao.bin on 16/3/25.
//  Copyright © 2016年 Zhao.bin. All rights reserved.
//

import UIKit

class popViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
       self.modalPresentationStyle = .custom
      
        
        // Do any additional setup after loading the view.
    }

    @IBAction func missButton(_ sender: UIButton)
    {
//        let time: NSTimeInterval = 0.5
//        let delay = dispatch_time(DISPATCH_TIME_NOW,
//                                  Int64(time * Double(NSEC_PER_SEC)))
//        dispatch_after(delay, dispatch_get_main_queue()) {
//           
//        }
        self.dismiss(animated: true, completion: nil)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
