//
//  MyViewController.swift
//  HTK
//
//  Created by Zhao.bin on 16/6/3.
//  Copyright © 2016年 赵斌. All rights reserved.
//

import UIKit

class MyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //请确认您要打开的应用已经下载 (要打开的应用连接为(%@))
        let url =   String(format:"123 ==  \("eee+++")%@ ==== ","123")
        print(url)
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
