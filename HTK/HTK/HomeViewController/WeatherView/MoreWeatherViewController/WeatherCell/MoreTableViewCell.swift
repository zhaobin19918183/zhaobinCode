//
//  MoreTableViewCell.swift
//  HTK
//
//  Created by Zhao.bin on 16/5/26.
//  Copyright © 2016年 赵斌. All rights reserved.
//

import UIKit

class MoreTableViewCell: UITableViewCell {
    
    var chart: PDChart!
    @IBOutlet weak var backView: UIView!
    var nightArray:NSMutableArray!
    override func awakeFromNib() {
        super.awakeFromNib()
        nightArray = NSMutableArray()
        // Initializ  ation code
    }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func weatherDataArray(_ weather:NSMutableArray ,index:IndexPath)
    {
        for index in 0...6
        {

           let night = (((weather[index] as AnyObject).value(forKey: "info") as AnyObject).value(forKey: "day") as AnyObject).object(at: 2)
           nightArray.add(night)
 
        }
       
        
        let lineChart: PDLineChart = self.getLineChart()
        chart = lineChart
        chart.strokeChart()
        backView.addSubview(lineChart)
        
    }
    func getLineChart() -> PDLineChart
    {
        let dataItem: PDLineChartDataItem = PDLineChartDataItem()
        //x,y 轴的宽度和数量
        dataItem.xMax = 7.0
        dataItem.xInterval = 1.0
        dataItem.yMax = 100.0
        dataItem.yInterval = 10.0
        
        let y1 = (nightArray[0] as AnyObject).doubleValue
        let y2 = (nightArray[1] as AnyObject).doubleValue
        let y3 = (nightArray[2] as AnyObject).doubleValue
        let y4 = (nightArray[3] as AnyObject).doubleValue
        let y5 = (nightArray[4] as AnyObject).doubleValue
        let y6 = (nightArray[5] as AnyObject).doubleValue
        let y7 = (nightArray[6] as AnyObject).doubleValue
        

        dataItem.pointArray = [CGPoint(x: 1.0, y: y1!), CGPoint(x: 2.0, y: y2!), CGPoint(x: 3.0, y: y3!), CGPoint(x: 4.0, y:y4!), CGPoint(x: 5.0, y: y5!), CGPoint(x: 6.0, y: y6!), CGPoint(x: 7.0, y: y7!)]
        dataItem.xAxesDegreeTexts = [ "一", "二", "三", "四", "五", "周六","周日"]
        dataItem.yAxesDegreeTexts = ["5", "10", "15", "20","25","30","35","40","45","50"]
        
        let lineChart: PDLineChart = PDLineChart(frame: CGRect(x: 0, y: 0, width: 320, height: 240), dataItem: dataItem)
        return lineChart
    }
    
    func getBarChart() -> PDBarChart {
        let dataItem: PDBarChartDataItem = PDBarChartDataItem()
        dataItem.xMax = 7.0
        dataItem.xInterval = 1.0
        dataItem.yMax = 100.0
        dataItem.yInterval = 10.0
        dataItem.barPointArray = [CGPoint(x: 1.0, y: 27.0), CGPoint(x: 2.0, y: 25.0), CGPoint(x: 3.0, y: 26.0), CGPoint(x: 4.0, y:28.0), CGPoint(x: 5.0, y: 28.0), CGPoint(x: 6.0, y: 29.0), CGPoint(x: 7.0, y: 29.0)]
        dataItem.xAxesDegreeTexts = ["周日", "一", "二", "三", "四", "五", "周六"]

        
        let barChart: PDBarChart = PDBarChart(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 240), dataItem: dataItem)
        return barChart
    }

    
}
