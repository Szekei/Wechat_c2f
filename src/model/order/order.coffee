connection = [['/lib/car/audi_white.jpg','/lib/car/bmw_white.jpg',0,'/lib/car/ford_white.jpg',0],[0,0,0,'/lib/car/ford_orange.jpg',0],[0,0,0,0,'/lib/car/chevrolet_yellow.jpg'],['/lib/car/audi_black.jpg',0,'/lib/car/porsche_black.jpg',0,0],['/lib/car/audi_red.jpg','/lib/car/bmw_red.jpg','/lib/car/porsche_red.jpg',0,'/lib/car/chevrolet_red.jpg'],[0,'/lib/car/bmw_gold.jpg',0,0,0],[0,0,'/lib/car/porsche_silvery.jpg','/lib/car/ford_silvery.jpg',0]]
#car_name = [['奥迪R8 （白）','宝马335i （白）',0,'福特野马 （白）',0],[0,0,0,'福特野马 （橙）',0],[0,0,0,0,'雪弗兰科迈罗 （黄）'],['奥迪R8 （黑）',0,'保时捷Panamera （黑）',0,0],['奥迪R8 （红）','宝马335i （红）','保时捷Panamera （红）',0,'雪弗兰科迈罗 （红）'],[0,'宝马335i （金）',0,0,0],[0,0,'保时捷Panamera （银）','福特野马 （银）',0]]
#car_title = '奥迪R8 （白）'
price_group = ['1830,000','300,000','1200,000','500,000','470,000']
urgent_price = ['1860,000','330,000','1230,000','530,000','500,000']
btn_unselected = 'btn-primary btn-unselected'
btn_selected = 'btn-primary btn-selected'
btn_disabled = 'btn-primary btn-disabled'
lastType = 'type100'
lastColor = 'color100'
lastPriority = -1
price = '1830,000'
car_type = -1
car_color = -1
car_image = "car/audi_white.jpg"
$(document).ready ->
  $('#loading').hide()
  $('#price').html('￥'+price)
  $('button').click ->
    if this.id.indexOf('priority') isnt -1
      selPri(this.id.substring this.id.indexOf('priority') + 8,this.id.indexOf('priority') + 9)
    else
      fun = if this.id.indexOf('type') is -1 then 1 else 0
      num = if fun is 0 then this.id.substring this.id.indexOf('type') + 4,this.id.indexOf('type') + 5 else this.id.substring this.id.indexOf('color') + 5, this.id.indexOf('color') + 6
      selCar this, fun, num
    checkSubmit()

  $('#submit').click ->
    if $('#submit').hasClass('btn-unavailable')
      return
    PostOrder(car_type, car_color,lastPriority)

  selCar = (obj,fun,index) ->
    if ($('#' + obj.id).hasClass 'btn-disabled') or ($('#' + obj.id).hasClass 'color-disabled')
      return
    if fun is 0
      for i in [0..6]
        if $('#color'+i).hasClass 'color-disabled'
          $('#color'+i).toggleClass 'color-disabled'
      if obj.id isnt lastType
        obj.className = obj.className.replace 'btn-unselected','btn-selected'
        if $('#'+lastType)&&$('#'+lastType).hasClass 'btn-selected'
          $('#'+lastType).toggleClass 'btn-selected btn-unselected'
        lastType = obj.id
        for i in [0..6]
          if connection[i][index] is 0
            if $('#color'+i).hasClass 'color-selected'
              $('#color'+i).toggleClass 'color-selected color-disabled'
            else
              $('#color'+i).toggleClass 'color-disabled'
        car_type = index
        if lastPriority is 1
          $('#price').html('￥'+urgent_price[car_type])
        else
          $('#price').html('￥'+price_group[car_type])
        if car_color isnt -1
          $('#car-img').attr 'src', connection[car_color][car_type]
          $('#carName').text car_name[car_color][car_type]
        else
          for p in [0..3]
            if connection[p][car_type] isnt 0
              $('#car-img').attr 'src', connection[p][car_type]
              $('#carName').text car_name[p][car_type]
              break
      else
        if $('#' + obj.id).hasClass 'btn-unselected'
          obj.className = obj.className.replace 'btn-unselected', 'btn-selected'
          for i in [0..6]
            if connection[i][index] is 0
              if $('#color'+i).hasClass 'color-selected'
                $('#color'+i).toggleClass 'color-selected color-disabled'
              else
                $('#color'+i).toggleClass 'color-disabled'
          car_type = index
          if lastPriority is 1
            $('#price').html('￥'+urgent_price[car_type])
          else
            $('#price').html('￥'+price_group[car_type])
          if car_color isnt -1
            $('#car-img').attr 'src', connection[car_color][car_type]
            $('#carName').text car_name[car_color][car_type]
          else
            for p in [0..3]
              if connection[p][car_type] isnt 0
                $('#car-img').attr 'src', connection[p][car_type]
                $('#carName').text car_name[p][car_type]
                break
        else
          obj.className = obj.className.replace 'btn-selected', 'btn-unselected'
          car_type = -1
          if car_color isnt -1
            for u in [0..4]
              if connection[car_color][u] isnt 0
                $('#car-img').attr 'src', connection[car_color][u]
                $('#carName').text car_name[car_color][u]
                break
          else
            $('#car-img').attr 'src', connection[0][0]
            $('#carName').text car_name[0][0]
          if lastPriority isnt 1
            $('#price').html('￥'+price_group[0])
          else
            $('#price').html('￥'+urgent_price[0])
    else
      for i in [0..4]
        if $('#type'+i).hasClass 'btn-disabled'
          $('#type'+i).toggleClass 'btn-disabled btn-unselected'
      if obj.id isnt lastColor
        $('#'+obj.id).toggleClass 'color-selected'
        if $('#'+lastColor)&&$('#'+lastColor).hasClass 'color-selected'
          $('#'+lastColor).toggleClass 'color-selected'
        lastColor = obj.id
        for i in [0..4]
          if connection[index][i] is 0
            if $('#type'+i).hasClass 'btn-selected'
              $('#type'+i).toggleClass 'btn-selected btn-disabled'
            else
              $('#type'+i).toggleClass 'btn-unselected btn-disabled'
        car_color = index;
        if car_type isnt -1
          $('#car-img').attr 'src', connection[car_color][car_type]
          $('#carName').text car_name[car_color][car_type]
        else
          for u in [0..4]
            if connection[car_color][u] isnt 0
              $('#car-img').attr 'src', connection[car_color][u]
              $('#carName').text car_name[car_color][u]
              break
      else
        if !($('#' + obj.id).hasClass 'color-selected')
          $('#'+obj.id).toggleClass 'color-selected'
          for i in [0..4]
            if connection[index][i] is 0
              if $('#type'+i).hasClass 'btn-selected'
                $('#type'+i).toggleClass 'btn-selected btn-disabled'
              else
                $('#type'+i).toggleClass 'btn-unselected btn-disabled'
          car_color = index
          if car_type isnt -1
            $('#car-img').attr 'src', connection[car_color][car_type]
            $('#carName').text car_name[car_color][car_type]
          else
            for u in [0..4]
              if connection[car_color][u] isnt 0
                $('#car-img').attr 'src', connection[car_color][u]
                $('#carName').text car_name[car_color][u]
                break
        else
          $('#'+obj.id).toggleClass 'color-selected'
          car_color = -1
          if car_type isnt -1
            for p in [0..3]
              if connection[p][car_type] isnt 0
                $('#car-img').attr 'src', connection[p][car_type]
                $('#carName').text car_name[p][car_type]
                break
          else
            $('#car-img').attr 'src', connection[0][0]
            $('#carName').text car_name[0][0]
            if lastPriority isnt 1
              $('#price').html('￥'+price_group[0])
            else
              $('#price').html('￥'+urgent_price[0])

  Presel = () ->
    if typeIndex and colorIndex
      selCar $('#type' + Number(typeIndex-1))[0], 0, Number(typeIndex-1)
      selCar $('#color' + Number(colorIndex-1))[0], 1, Number(colorIndex-1)
    return

  Presel()
  selPri = (index) ->
    if index is '0'
      if lastPriority is 0
        $('#priority0').toggleClass 'btn-unselected btn-selected'
        lastPriority = -1
      else
        $('#priority0').toggleClass 'btn-unselected btn-selected'
        if lastPriority is 1
          $('#priority1').toggleClass 'btn-unselected btn-selected'
        if car_type isnt -1
          $('#price').html('￥'+price_group[car_type])
        else
          $('#price').html('￥'+price_group[0])
        lastPriority = 0
    else
      if lastPriority is 1
        $('#priority1').toggleClass 'btn-unselected btn-selected'
        $('#price').html('￥'+price_group[car_type])
        lastPriority = -1
      else
        if lastPriority is 0
          $('#priority0').toggleClass 'btn-unselected btn-selected'
        $('#priority1').toggleClass 'btn-unselected btn-selected'
        if car_type isnt -1
          $('#price').html('￥'+urgent_price[car_type])
        else
          $('#price').html('￥'+urgent_price[0])
        lastPriority = 1

  checkSubmit = () ->
    if car_color isnt -1 and car_type isnt -1 and lastPriority isnt -1
      if $('#submit').hasClass 'btn-unavailable'
        $('#submit').toggleClass 'btn-unavailable btn-available'
    else
      if $('#submit').hasClass 'btn-available'
        $('#submit').toggleClass 'btn-unavailable btn-available'

  BaseUrl = 'http://p526.coil.sap.com:50003/MFGInno1/rest/WeChatService/createOrder'
  createOrderUrl = 'http://115.29.136.24/api/v1/orders'

  PostOrder = (car_type, car_color,priority) ->
    $('#loading').show()
    data = {type: Number(car_type)+1, color: Number(car_color)+1, priority: Number(lastPriority)+1}
    $.ajax({
      url: BaseUrl,
      type: "POST",
      dataType: "json",
      data: JSON.stringify(data),
      cache: false,
      async: true,
      contentType: "application/json",
      crossDomain: true,
      success: (data) ->
        if data.salesOrderID
          $('#loading').hide()
          alert 'Order ' + data.salesOrderID + ' created'
          localStorage['orderId'] = data.salesOrderID
          localStorage['img'] = connection[car_color][car_type]
          localStorage['carName'] = car_name[car_color][car_type]
          localStorage['type']=car_type
          localStorage['color']=car_color
          data.erpOrderId = data.salesOrderID
          data.type = car_type;
          data.color = car_color;
          data.priority = priority;
          $.ajax({
            url: createOrderUrl,
            type: 'POST',
            dataType: 'json',
            data: JSON.stringify(data),
            contentType: "application/json",
            cache: false,
            success: (createRes) ->
              window.location = '/order/state'
            error: (xmlHttpRequest, textStatus, errorThrown) ->
              alert errorThrown
          })
        else
          alert 'post is fail'
      error: (xmlHttpRequest, textStatus, errorThrown) ->
        alert errorThrown
        if (xmlHttpRequest.readyState is 0) or (xmlHttpRequest.status is 0)
          alert 'Request is fail'
    })

