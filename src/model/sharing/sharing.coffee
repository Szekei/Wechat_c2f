
wx.config({
  debug: false,
  appId: appId,
  timestamp: timestamp,
  nonceStr: nonceStr,
  signature: signature,
  jsApiList: ['onMenuShareAppMessage', 'onMenuShareTimeline']
})

wx.ready () ->
  type = localStorage['type']
  color = localStorage['color']
#  headImgUrl = localStorage['headImgUrl']
#  alert type
#  alert color
  wx.onMenuShareAppMessage({
    title: 'I BOUGHT A NEW CAR!',
    desc: "It's really cool",
    link: 'http://115.29.136.24/sharing?type=' + type + '&color=' + color + '&headImgUrl=' + headImgUrl,
    imgUrl: 'http://115.29.136.24' + imgsrc,
    type: 'link',
    dataUrl: '',
    success: () ->
      console.log('succ')
    cancel: () ->
      console.log('cancel')
  })

  wx.onMenuShareTimeline({
    title: 'I BOUGHT A NEW CAR!',
    link: 'http://115.29.136.24/sharing?type=' + type + '&color=' + color + '&headImgUrl=' + headImgUrl,
    imgUrl: 'http://115.29.136.24' + imgsrc,
    success: () ->
      console.log('succ')
    cancel: () ->
      console.log('cancel')
  })