
//
//  EndWebViewController.swift
//  NBALive
//
//  Created by Zhao.bin on 16/10/13.
//  Copyright © 2016年 Zhao.bin. All rights reserved.
//

import UIKit

class EndWebViewController: UIViewController {

    var  uslString :String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "比赛数据"
        let webView = UIWebView(frame:self.view.bounds)
        let url = NSURL(string:uslString)
        let request = NSURLRequest(url: url as! URL)
        webView.loadRequest(request as URLRequest)
        self.view.addSubview(webView)

        // Do any additional setup after loading the view.
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
