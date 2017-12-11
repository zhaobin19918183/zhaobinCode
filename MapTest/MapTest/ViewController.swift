//
//  ViewController.swift
//  MapTest
//
//  Created by newland on 2017/12/8.
//  Copyright © 2017年 newland. All rights reserved.
//

import UIKit
import Alamofire
import MapKit
import AVFoundation
class ViewController: UIViewController,UITableViewDelegate ,UITableViewDataSource{
    
    
    @IBOutlet weak var homeTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
   
        
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    //cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        
  
        
        return cell
    }
    
    //table的cell高度，可选方法
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let secondViewController = BeginRecordViewController()
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
        
        
    }
    

    




    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

