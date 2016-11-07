//
//  EndTableViewCell.swift
//  NBALive
//
//  Created by Zhao.bin on 16/10/12.
//  Copyright © 2016年 Zhao.bin. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class EndTableViewCell: UITableViewCell {

    @IBOutlet weak var _teamName1: UILabel!
    @IBOutlet weak var _teamNumber: UILabel!
    @IBOutlet weak var _teamName2: UILabel!
    @IBOutlet weak var _teamActionTime: UILabel!
    @IBOutlet weak var _teamImageView1: UIImageView!
    @IBOutlet weak var _teamImageView2: UIImageView!
    @IBOutlet weak var dataStatisticsButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateTitleLabel: UILabel!
    @IBOutlet weak var videoButton: UIButton!
    var navigationController:UINavigationController!
    var dataString:String!
    var videoString:String!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }
    func  endLiveAction(dic:[String:AnyObject])
    {
      dateLabel.text = dic["title"] as? String
    }
    func  endLiveDicAction(dic:[String:AnyObject] ,tableview:UITableView)
    {
        //[player1logo, player2logobig, m_link1url, m_link2url, score, player2logo, time, link2text, link1text, player2, player1logobig, link1url, player1url, link2url, player1, status, player2url]
        _teamName1.text = dic["player1"] as? String
        _teamName2.text = dic["player2"] as? String
        _teamNumber.text = dic["score"] as? String
        _teamActionTime.text = dic["time"] as? String
        _teamImageView1.tag = 1
        _teamImageView2.tag = 2
        teamImagelogo(url: dic["player2logo"] as! String,imageview:_teamImageView2)
        teamImagelogo(url: dic["player1logobig"] as! String,imageview:_teamImageView1)
        self.dataString = dic["link1url"] as! String
    }

    @IBAction func dataAction(_ sender: UIButton)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let targetVC0 = storyboard.instantiateViewController(withIdentifier: "EndWebViewController") as! EndWebViewController
        targetVC0.uslString = self.dataString
        self.navigationController?.pushViewController(targetVC0, animated:true)
        
        
    }
    func teamImagelogo(url:String,imageview:UIImageView)
    {
        Alamofire.request(url).responseImage { (response) in
            if imageview.tag == 1
            {
                if let image = response.result.value {
                    self._teamImageView1.image = image
                }
            }
            else
            {
                if let image = response.result.value {
                    self._teamImageView2.image = image
                }
            }
          
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
}
