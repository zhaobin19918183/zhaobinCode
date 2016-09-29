//
//  ShoppingCarViewController.swift
//  minishop
//
//  Created by Zhao.bin on 16/3/15.
//  Copyright © 2016年 Zhao.bin. All rights reserved.
//

import UIKit

class ShoppingCarViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var _menuTableView: UITableView!
    
    @IBOutlet weak var _productTableView: UITableView!
    
    var sec = ["1","2","3","4","5","6","7","8","9","10"]
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(tableView.isEqual(_menuTableView))
        {
            let initIdentifier : String = "MenuTableViewCell"
            var cell : MenuTableViewCell? = tableView.dequeueReusableCell(withIdentifier: initIdentifier) as? MenuTableViewCell
            if cell == nil
            {
                let nibArray = Bundle.main.loadNibNamed("MenuTableViewCell", owner: self, options: nil)
                cell = nibArray?.first as? MenuTableViewCell
                cell?._menuNameLable.text = self.sec[(indexPath as NSIndexPath).row]
            }
            return cell!
        }
        
        let initIdentifier : String = "ProductTableViewCell"
        var cell : ProductTableViewCell? = tableView.dequeueReusableCell(withIdentifier: initIdentifier) as? ProductTableViewCell
        if cell == nil
        {
            let nibArray = Bundle.main.loadNibNamed("ProductTableViewCell", owner: self, options: nil)
            cell = nibArray?.first as? ProductTableViewCell
            
        }
       cell?.index = (indexPath as NSIndexPath).row
       cell?.section = (indexPath as NSIndexPath).section
       
       return cell!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(tableView.isEqual(_menuTableView))
        {
            return 50
        }
        else if(tableView.isEqual(_productTableView))
        {
            return 100
        }
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(tableView.isEqual(_menuTableView))
        {
            return self.sec.count
        }
        else if(tableView.isEqual(_productTableView))
        {
            return self.sec.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if(tableView.isEqual(_productTableView))
        {
            return self.sec[section]
        }
        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 20
    }
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if (tableView.isEqual(_productTableView))
        {
            return 10
        }
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if(tableView.isEqual(_productTableView))
        {
          print(2222222)
        }
        else
        if(tableView.isEqual(_menuTableView))
        {
         _productTableView?.selectRow(at: IndexPath(row: 0, section: (indexPath as NSIndexPath).row), animated: true, scrollPosition: .top)
         _productTableView.reloadData()
       
        }
    }
    //TODO:header display

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if(tableView.isEqual(_productTableView))
        {
        _menuTableView.selectRow(at: IndexPath(row: section, section: 0), animated: true, scrollPosition: UITableViewScrollPosition.middle)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
