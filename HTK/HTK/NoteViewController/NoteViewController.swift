//
//  NoteViewController.swift
//  HTK
//
//  Created by 赵斌 on 16/5/16.
//  Copyright © 2016年 赵斌. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {

    @IBOutlet weak var _photosSelectView: PhotosSelectView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
      _photosSelectView.photosSelectView = self.parentViewController!
      
    }

    
   


}
