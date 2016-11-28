var date
var temperature
var info
var direct
var power
var GetList = function (that) {
    that.setData({
        hidden: false
    });

    wx.request({
        url: 'http://op.juhe.cn/onebox/weather/query',
        data: {
            cityname: '大连',
            key: 'e527188bbf687ccccac5350acf9a151f'
        },
        method: 'GET', // OPTIONS, GET, HEAD, POST, PUT, DELETE, TRACE, CONNECT
        // header: {}, // 设置请求的 header
        success: function (res) {
            // success
            console.log(res.data.result.data.realtime)
            date = res.data.result.data.realtime.date
            temperature = res.data.result.data.realtime.weather.temperature
            info = res.data.result.data.realtime.weather.info
            direct = res.data.result.data.realtime.wind.direct
            power = res.data.result.data.realtime.wind.power
            that.setData({
                date: date,
                temperature: temperature,
                info: info,
                direct: direct,
                power: power,
                hidden: true
            });
        },
        fail: function () {
            console.log("fail")
            wx.showModal({
                title: '提示',
                content: '请求链接超市',
                showCancel: false,
                success: function (res) {
                    if (res.confirm) {
                        console.log('用户点击确定')
                    }
                } 
                })
                // fail
            },
                complete: function () {
                    // complete
                }
    })
}
Page({

    data: {
        date: date,
        temperature: temperature,
        info: info,
        direct: direct,
        power: power,
        hidden: false
    },

    onLoad: function (options) {
        // 页面初始化 options为页面跳转所带来的参数


    },
    onReady: function () {
        // 页面渲染完成


    },
    onShow: function () {
        // 页面显示
        var that = this;
        GetList(that);

    },
    onHide: function () {
        // 页面隐藏

    },
    onUnload: function () {
        // 页面关闭

    }
})