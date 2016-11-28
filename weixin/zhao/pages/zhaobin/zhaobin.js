Page({
  data:{
    
  },
  setLoading: function(e) {
     wx.request({
       url: 'https://app.innocellence.com/internal/api/v1/signin',
       data: {
         name:'bin.zhao',
         pass:'Zhaobin041123'
       },
       method: 'POST', // OPTIONS, GET, HEAD, POST, PUT, DELETE, TRACE, CONNECT
       success: function(res){
         // success
          console.log(res.data)
       },
       fail: function() {
         // fail
          console.log("fail 11")
       },
       complete: function() {
         // complete
       }
     })
  }
}

)