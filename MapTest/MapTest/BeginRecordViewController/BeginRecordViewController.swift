//
//  BeginRecordViewController.swift
//  MapTest
//
//  Created by newland on 2017/12/11.
//  Copyright © 2017年 newland. All rights reserved.
//

import UIKit

class BeginRecordViewController: UIViewController {

    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var MapView: UIView!
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var recordTimeLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var GPSLabel: UIView!
    @IBOutlet weak var EZAudioView: UIView!
    @IBOutlet weak var buttionVIew: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var BeginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BeginRecordAction(_ sender: UIButton) {
    }
    
    @IBAction func BackAction(_ sender: UIButton) {
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
