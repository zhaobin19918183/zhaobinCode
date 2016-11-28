var url = "http://op.juhe.cn/onebox/basketball/nba?dtype=&=&key=a77b663959938859a741024f8cbb11ac";
var page = 0;
var page_size = 20;
var sort = "last";
var is_easy = 0;
var lange_id = 0;
var pos_id = 0;
var unlearn = 0;
//获取数据
var GetListOther = function (that) {
  that.setData({
    hidden: false
  });
  wx.request({
    url: url,
    success: function (res) {
      //取出数据
      var list = that.data.list;//???????????
      for (var i = 0; i < res.data.result.list[1].tr.length; i++) {
        //status

        var strString = res.data.result.list[1].tr[i].status

        if (strString == "2") {
          list.push(res.data.result.list[1].tr[i]);
          console.log("添加")
        }
        else {
       console.log("没有添加")
        }

      }

      //将数据从控制层传到视图层
      that.setData({
        list: list,
      });
      //???????
      page++;
      //????????????
      that.setData({
        hidden: true
      });
    }
  });
}

var GetList = function (that) {
  that.setData({
    hidden: false
  });
  wx.request({
    url: url,
    success: function (res) {
      //取出数据
      var list = that.data.list;//???????????
      for (var i = 0; i < res.data.result.list[0].tr.length; i++) {
        list.push(res.data.result.list[0].tr[i]);
      }
      console.log(list)
      //将数据从控制层传到视图层
      that.setData({
        list: list,
      });
      //???????
      page++;
      //????????????
      that.setData({
        hidden: true
      });
    }
  });
}
Page({
  data: {
    hidden: true,
    //初始化
    list: [],
    scrollTop: 0,
    scrollHeight: 0
  },
  onLoad: function (options) {
    // 页面初始化 options为页面跳转所带来的参数
    var that = this;
    //获取设备信息
    wx.getSystemInfo({
      success: function (res) {
        console.info(res.windowHeight);
        that.setData({
          scrollHeight: res.windowHeight
          // res.windowWidth; 
        });
      }
    });
  },
  onReady: function () {
    // 页面渲染完成

  },
  onShow: function () {
    // 页面显示  //  在页面展示之后先获取一次数据
    var that = this;
    GetList(that);
  },
  bindDownLoad: function () {
    //  该方法绑定了页面滑动到底部的事件
    var that = this;
    GetListOther(that);

  },
  scroll: function (event) {
    //  该方法绑定了页面滚动时的事件，我这里记录了当前的position.y的值,为了请求数据之后把页面定位到这里来。
    this.setData({
      scrollTop: event.detail.scrollTop
    });
  },
  refresh: function (event) {
    // 该方法绑定了页面滑动到顶部的事件，然后做上拉刷新
    //  page = 0;
    //  this.setData({
    //    list : [],
    //    scrollTop : 0
    //  });
    //  GetList(this)
    //数组追加元素  
    // this.setData({
    //  'list':this.data.list.concat('list')
    // });
  }
})
