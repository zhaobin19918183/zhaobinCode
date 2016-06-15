//
//  NoteTextView.swift
//  HTK
//
//  Created by Zhao.bin on 16/6/15.
//  Copyright © 2016年 赵斌. All rights reserved.
//

import UIKit

class NoteTextView: UIView,UITextViewDelegate {

    @IBOutlet var _noteTextView: NoteTextView!
   
    @IBOutlet weak var textView: UITextView!
    required init(coder aDecoder: NSCoder){
        
        super.init(coder: aDecoder)!
        resetUILayout()

    }
    
    func  resetUILayout()
    {
        NSBundle.mainBundle().loadNibNamed("NoteTextView", owner:self,options:nil)
//        self.textView.layer.borderColor = UIColor(red: 60/255, green: 40/255, blue: 129/255, alpha: 1).CGColor;
//        self.textView.layer.borderWidth = 2
//        self.textView.layer.cornerRadius = 16
     
        self.addSubview(_noteTextView)
    }
    func textViewDidEndEditing(textView: UITextView) {
    
    }




}
