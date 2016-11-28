var name
var address
var numberid
var email
Page({
  data: {
    
  },
  bindKeyInput: function (e) {
    if (e.target.id == "1") {

      name = e.detail.value
    }
    if (e.target.id == "2") {
      address = e.detail.value
    }
    if (e.target.id == "3") {
      numberid = e.detail.value

    }
    if (e.target.id == "4") {
      email = e.detail.value
    }
  },
  submit: function () {
    console.log(name)
    console.log(address)
    console.log(numberid)
    console.log(email)
    if (numberid.length < 10) {
      wx.showModal({
        title: '提示',
        content: '身份证号输入错误',
        showCancel:false,
        success: function (res) {
          if (res.confirm) {
            console.log('用户点击确定')
          }
        }
      })
      console.log("输入错误")
    }
   else
   {
      wx.request({
      url: "http://127.0.0.1:8000/blog/wxSmall",
      method: "POST",
      header: {
        "content-type": "application/x-www-form-urlencoded"
      },
      data: {
        name:name,
        address: address,
        numberid: numberid,
        email: email,
      },
      success: function (res) {
        console.info(res);
      }
    });

   }
  
  }
})
