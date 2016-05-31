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
  
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func weatherDataArray(weather:NSMutableArray ,index:NSIndexPath)
    {

        for index in 0...6
        {

           let night = weather[index].valueForKey("info")?.valueForKey("night")?.objectAtIndex(2)
           nightArray.addObject(night!)
 
        }
        print(nightArray[0].integerValue)
        
        let lineChart: PDLineChart = self.getLineChart()
        chart = lineChart
        chart.strokeChart()
        backView.addSubview(lineChart)
        
    }
    func getLineChart() -> PDLineChart {
        let dataItem: PDLineChartDataItem = PDLineChartDataItem()
        dataItem.xMax = 7.0
        dataItem.xInterval = 1.0
        dataItem.yMax = 100.0
        dataItem.yInterval = 10.0
        let y1 = nightArray[0].doubleValue
        let y2 = nightArray[1].doubleValue
        let y3 = nightArray[2].doubleValue
        let y4 = nightArray[3].doubleValue
        let y5 = nightArray[4].doubleValue
        let y6 = nightArray[5].doubleValue
        let y7 = nightArray[6].doubleValue
        dataItem.pointArray = [CGPoint(x: 1.0, y: y1), CGPoint(x: 2.0, y: y2), CGPoint(x: 3.0, y: y3), CGPoint(x: 4.0, y:y4), CGPoint(x: 5.0, y: y5), CGPoint(x: 6.0, y: y6), CGPoint(x: 7.0, y: y7)]
        dataItem.xAxesDegreeTexts = [ "一", "二", "三", "四", "五", "周六","周日"]
        dataItem.yAxesDegreeTexts = ["5", "10", "15", "20","25","30","35","40","45","50"]
        
        let lineChart: PDLineChart = PDLineChart(frame: CGRectMake(0, 0, 320, 240), dataItem: dataItem)
        return lineChart
    }
    
    func getBarChart() -> PDBarChart {
        let dataItem: PDBarChartDataItem = PDBarChartDataItem()
        dataItem.xMax = 7.0
        dataItem.xInterval = 1.0
        dataItem.yMax = 100.0
        dataItem.yInterval = 10.0
        dataItem.barPointArray = [CGPoint(x: 1.0, y: 95.0), CGPoint(x: 2.0, y: 80.0), CGPoint(x: 3.0, y: 80.0), CGPoint(x: 4.0, y:80.0), CGPoint(x: 5.0, y: 80.0), CGPoint(x: 6.0, y: 60.0), CGPoint(x: 7.0, y: 90.0)]
        dataItem.xAxesDegreeTexts = ["周日", "一", "二", "三", "四", "五", "周六"]
        dataItem.yAxesDegreeTexts = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
        
        let barChart: PDBarChart = PDBarChart(frame: CGRectMake(0, 100, 320, 320), dataItem: dataItem)
        return barChart
    }
    
}
