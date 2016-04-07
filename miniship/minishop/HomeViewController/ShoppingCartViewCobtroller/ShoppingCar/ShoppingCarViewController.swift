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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if(tableView.isEqual(_menuTableView))
        {
            let initIdentifier : String = "MenuTableViewCell"
            var cell : MenuTableViewCell? = tableView.dequeueReusableCellWithIdentifier(initIdentifier) as? MenuTableViewCell
            if cell == nil
            {
                let nibArray = NSBundle.mainBundle().loadNibNamed("MenuTableViewCell", owner: self, options: nil)
                cell = nibArray.first as? MenuTableViewCell
                cell?._menuNameLable.text = self.sec[indexPath.row]
            }
            return cell!
        }
        
        let initIdentifier : String = "ProductTableViewCell"
        var cell : ProductTableViewCell? = tableView.dequeueReusableCellWithIdentifier(initIdentifier) as? ProductTableViewCell
        if cell == nil
        {
            let nibArray = NSBundle.mainBundle().loadNibNamed("ProductTableViewCell", owner: self, options: nil)
            cell = nibArray.first as? ProductTableViewCell
            
        }
       cell?.index = indexPath.row
       cell?.section = indexPath.section
       
       return cell!
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
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
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
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
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if(tableView.isEqual(_productTableView))
        {
            return self.sec[section]
        }
        return nil
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 20
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        if (tableView.isEqual(_productTableView))
        {
            return 10
        }
        return 1
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if(tableView.isEqual(_productTableView))
        {
          print(2222222)
        }
        else
        if(tableView.isEqual(_menuTableView))
        {
         _productTableView?.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: indexPath.row), animated: true, scrollPosition: .Top)
         _productTableView.reloadData()
       
        }
    }
    //TODO:header display

    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if(tableView.isEqual(_productTableView))
        {
        _menuTableView.selectRowAtIndexPath(NSIndexPath(forRow: section, inSection: 0), animated: true, scrollPosition: UITableViewScrollPosition.Middle)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
