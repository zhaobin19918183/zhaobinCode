
//
//  ShopCarViewController.swift
//  FamilyShop
//
//  Created by Zhao.bin on 16/9/29.
//  Copyright © 2016年 Zhao.bin. All rights reserved.
//

import UIKit

class ShopCarViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title   = "ShoppingCar"
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let initIdentifier : String = "TableViewCellID"
        var cell : ShopCarTableViewCell? = tableView.dequeueReusableCell(withIdentifier: initIdentifier) as? ShopCarTableViewCell
        if cell == nil
        {
            let nibArray = Bundle.main.loadNibNamed("ShopCarTableViewCell", owner: self, options: nil)
            cell = nibArray?.first as? ShopCarTableViewCell
        }

        return cell!
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 80
    }
    


}
