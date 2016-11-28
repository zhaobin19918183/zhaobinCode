var teststring
Page({
  data: {
    request: {}
  },
  onLoad: function (options) {
    
    // 页面初始化 options为页面跳转所带来的参数
    wx.request({
      url: 'http://op.juhe.cn/onebox/basketball/nba?dtype=&=&key=a77b663959938859a741024f8cbb11ac',
      method: 'GET', // OPTIONS, GET, HEAD, POST, PUT, DELETE, TRACE, CONNECT
      success: function (res) {
        // success
        console.log(res.data.result.list)
        try {

          wx.setStorageSync('res', res)
        } catch (e) {
          console.log("error")
        }
        teststring = res.data.result.title
        // wx.setNavigationBarTitle({
        //   title: teststring
        // })

        console.log(res.data.result.list.length)
      },
      fail: function () {
        // fail
        console.log("fail")
      },
      complete: function () {
        // complete
      }
    })
  },
  onReady: function () {

  },
  onShow: function () {
    // 页面显示
    console.log(teststring)
  },
  onHide: function () {
    // 页面隐藏

  },
  onUnload: function () {
    // 页面关闭


  },
  NotBeginAction: function () {
    wx.navigateTo({
      url: '../zhaobin/basketball/basketball'
    })
  },
  //
  StartAction: function () {
    console.log("start")
    //页面跳转方法
    wx.navigateTo({
      url: '../logs/logs'
    })
  },
  JokeAction:function()
  {
     wx.navigateTo({
       url: '../zhaobin/joke/joke'
    })
  },
  EndAction: function () {
     wx.navigateTo({
       url: '../zhaobin/django/django'
    })
    //http 申请
    //url,method,header ,data 注意顺序,method 顺序要放在 header 和 data 前面
    //使用 post 需要在  header中添加"content-type": "application/x-www-form-urlencoded"其中 "content-type"必须要小写
    
    // wx.request({
    //   url: "http://127.0.0.1:8000/blog/wxSmall",
    //   method: "POST",
    //   header: {
    //     "content-type": "application/x-www-form-urlencoded"
    //   },
    //   data: {
    //     name: 'name2',
    //     address: 'address',
    //     numberid: '111111111111111111',
    //     email: 'bin.zhao@innocellence.com',
    //   },
    //   success: function (res) {
    //     console.info(res);

    //   }
    // });

    //   try {
    //   var value = wx.getStorageSync('res')
    //   if (value) {
    //       // Do something with return value
    //       console.log(value.data.result.title)
    //       console.log("success")
    //   }
    // } catch (e) {
    //   console.log("error")
    //   // Do something when catch error
    // }

  }
}

)