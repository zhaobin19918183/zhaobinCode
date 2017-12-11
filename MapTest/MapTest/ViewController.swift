//
//  ViewController.swift
//  MapTest
//
//  Created by newland on 2017/12/8.
//  Copyright © 2017年 newland. All rights reserved.
//

import UIKit
import Alamofire
import MapKit
import AVFoundation
class ViewController: UIViewController ,MAMapViewDelegate,CLLocationManagerDelegate,MKMapViewDelegate{
    @IBOutlet weak var playbackSlider: UISlider!
    @IBOutlet weak var playButton: UIButton!
    
    
    @IBOutlet weak var playTime: UILabel!
    
    var locationManager = AMapLocationManager()
    
    var currentCoordinate:CLLocationCoordinate2D?
    
    //播放器相关
    var playerItem:AVPlayerItem?
    var player:AVPlayer?
    var coredata:AudioDAO?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //初始化播放器
        let url = URL(string: "https://www.hangge.com/music.mp3")
        playerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem!)
        
//        AudioDAO.creatBookListEntity();
        
        //设置进度条相关属性
        let duration : CMTime = playerItem!.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        playbackSlider!.minimumValue = 0
        playbackSlider!.maximumValue = Float(seconds)
        playbackSlider!.isContinuous = false
        
        //播放过程中动态改变进度条值和时间标签
        player!.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, 1),
                                        queue: DispatchQueue.main) { (CMTime) -> Void in
                                            if self.player!.currentItem?.status == .readyToPlay {
                                                //更新进度条进度值
                                                let currentTime = CMTimeGetSeconds(self.player!.currentTime())
                                                self.playbackSlider!.value = Float(currentTime)
                                                
                                                //一个小算法，来实现00：00这种格式的播放时间
                                                let all:Int=Int(currentTime)
                                                let m:Int=all % 60
                                                let f:Int=Int(all/60)
                                                var time:String=""
                                                if f<10{
                                                    time="0\(f):"
                                                }else {
                                                    time="\(f)"
                                                }
                                                if m<10{
                                                    time+="0\(m)"
                                                }else {
                                                    time+="\(m)"
                                                }
                                                //更新播放时间
                                                self.playTime!.text=time
                                            }
        }
        
        
//
//        AMapServices.shared().enableHTTPS = true
//        let mapView = MAMapView(frame: self.view.bounds)
//        mapView.delegate = self
//        mapView.showsUserLocation = true
//        mapView.userTrackingMode = .follow
////        self.view.addSubview(mapView)
//
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//
//        locationManager.locationTimeout = 10
//
//        locationManager.reGeocodeTimeout = 10
//
//
//        locationManager.requestLocation(withReGeocode: false, completionBlock: { (location: CLLocation?, reGeocode: AMapLocationReGeocode?, error: Error?) in
//
//            if let error = error {
//                let error = error as NSError
//
//                if error.code == AMapLocationErrorCode.locateFailed.rawValue {
//                    //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
//                    NSLog("定位错误:{\(error.code) - \(error.localizedDescription)};")
//                    return
//                }
//                else if error.code == AMapLocationErrorCode.reGeocodeFailed.rawValue
//                    || error.code == AMapLocationErrorCode.timeOut.rawValue
//                    || error.code == AMapLocationErrorCode.cannotFindHost.rawValue
//                    || error.code == AMapLocationErrorCode.badURL.rawValue
//                    || error.code == AMapLocationErrorCode.notConnectedToInternet.rawValue
//                    || error.code == AMapLocationErrorCode.cannotConnectToHost.rawValue {
//
//                    //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
//                    NSLog("逆地理错误:{\(error.code) - \(error.localizedDescription)};")
//                }
//                else {
//                    //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
//                }
//            }
//
//            if let location = location {
//                NSLog("location:%@", location)
//            }
//
//            if let reGeocode = reGeocode {
//                NSLog("reGeocode:%@", reGeocode)
//            }
//        })
//        // Do any additional setup after loading the view, typically from a nib.
    }
    //播放按钮点击
    @IBAction func playButtonTapped(_ sender: Any) {
        //根据rate属性判断当天是否在播放
        if player?.rate == 0 {
            player!.play()
            playButton.setTitle("暂停", for: .normal)
        } else {
            player!.pause()
            playButton.setTitle("播放", for: .normal)
        }
    }
    
    //拖动进度条改变值时触发
    @IBAction func playbackSliderValueChanged(_ sender: Any) {
        let seconds : Int64 = Int64(playbackSlider.value)
        let targetTime:CMTime = CMTimeMake(seconds, 1)
        //播放器定位到对应的位置
        player!.seek(to: targetTime)
        //如果当前时暂停状态，则自动播放
        if player!.rate == 0
        {
            player?.play()
            playButton.setTitle("暂停", for: .normal)
        }
    }
    
    //页面显示时添加歌曲播放结束通知监听
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(finishedPlaying),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
    }
    
    //页面消失时取消歌曲播放结束通知监听
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    //歌曲播放完毕
    @objc func finishedPlaying(myNotification:NSNotification) {
        print("播放完毕!")
        let stopedPlayerItem = myNotification.object as! AVPlayerItem
        stopedPlayerItem.seek(to: kCMTimeZero, completionHandler: nil)
        playButton.setTitle("播放", for: .normal)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

