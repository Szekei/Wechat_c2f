#alert('display')

lastTag = ''
#colorType = ['#F7464A','#46BFBD','#FDB45C','#949FB1','#4D5360']
#colorCol = ['#990066','#FFCC00','#CCD033','#009999','#886699','#FF6600','#006699']
#highlightType = ['#FF5A5E','#5AD3D1','#FFC870','#A8B3C5','#616774']
#highlightCol = ['#FF5A5E','#5AD3D1','#FFC870','#A8B3C5','#616774','#990066','#FFCC00']

colorType = ['#66CCCC', '#FF9999', '#FF99CC', '#99CC66', '#FFCC00']
highlightType = ['#66CCCC', '#FF9999', '#FF99CC', '#99CC66', '#FFCC00']
colorCol = ['white', 'orange', 'yellow', 'black', 'red', 'gold', 'silver']
highlightCol = ['white', 'orange', 'yellow', 'black', 'red', 'gold', 'silver']

#BaseUrl = 'http://localhost:3000/api/v1/analyse'
BaseUrl = 'http://115.29.136.24/api/v1/analyse'
TypeCount = [0,0,0,0,0]
ColorCount = [0,0,0,0,0,0,0]
typeData = [
  {
    value: TypeCount[0],
    color: colorType[0],
    highlight: highlightType[0],
    label: carName[0]
  },
  {
    value: TypeCount[1],
    color: colorType[1],
    highlight: highlightType[1],
    label: carName[1]
  },
  {
    value: TypeCount[2],
    color: colorType[2],
    highlight: highlightType[2],
    label: carName[2]
  },
  {
    value: TypeCount[3],
    color: colorType[3],
    highlight: highlightType[3],
    label: carName[3]
  },
  {
    value: TypeCount[4],
    color: colorType[4],
    highlight: highlightType[4],
    label: carName[4]
  }
]
colorData = [
  {
    value: ColorCount[0],
    color: colorCol[0],
    highlight: highlightCol[0],
    label: carColor[0]
  },
  {
    value: ColorCount[1],
    color: colorCol[1],
    highlight: highlightCol[1],
    label: carColor[1]
  },
  {
    value: ColorCount[2],
    color: colorCol[2],
    highlight: highlightCol[2],
    label: carColor[2]
  },
  {
    value: ColorCount[3],
    color: colorCol[3],
    highlight: highlightCol[3],
    label: carColor[3]
  },
  {
    value: ColorCount[4],
    color: colorCol[4],
    highlight: highlightCol[4],
    label: carColor[4]
  },
  {
    value: ColorCount[5],
    color: colorCol[5],
    highlight: highlightCol[5],
    label: carColor[5]
  },
  {
    value: ColorCount[6],
    color: colorCol[6],
    highlight: highlightCol[6],
    label: carColor[6]
  }
]
$(document).ready ->
  for i in [0..4]
    $('#color' + i).css 'background-color' , colorType[i]
    $('#legend' + i).css 'color' , colorType[i]
  for s in [0..6]
    $('#colors' + s).css 'background-color' , colorCol[s]
    $('#legends' + s).css 'color' , colorCol[s]
  $('li').click ->
    if this.id.indexOf('legend') isnt -1
      return
    index = this.id
    selChart index
  selChart = (num) ->
    if num is lastTag
      return
    else
      $('#'+lastTag).toggleClass 'tag-unselected tag-selected'
      $('#'+num).toggleClass 'tag-unselected tag-selected'
      lastTag = num
      $.ajax({
        url: BaseUrl,
        type: "GET",
        dataType: "json",
        cache: false,
        async: true,
        contentType: "application/json",
        crossDomain: true,
        success: (data) ->
          typeDataArr = []
          colorDataArr = []
          if num is 'tag0'
            typeDataArr = data.all.type
            colorDataArr = data.all.color
          else if num is 'tag1'
            typeDataArr = data.male.type
            colorDataArr = data.male.color
          else
            typeDataArr = data.female.type
            colorDataArr = data.female.color

          # Clear at first
          for i in [0..4]
            typeData[i].value=0
          for i in [0..6]
            colorData[i].value=0
          # Use data
          for i in [0..typeDataArr.length - 1]
            if typeDataArr.length is 0
              break
            else  
              typeData[typeDataArr[i].type].value = typeDataArr[i].count
          for i in [0..colorDataArr.length - 1]
            if colorDataArr.length is 0
              break
            else  
              colorData[colorDataArr[i].color].value = colorDataArr[i].count

          ctx = document.getElementById('chart-area').getContext('2d')
          window.myPie = new Chart(ctx).Pie(typeData)
#          console.log TypeCount
#          console.log typeData
          ctxs = document.getElementById('chart-field').getContext('2d')
          window.myPie = new Chart(ctxs).Pie(colorData)
        error: (xmlHttpRequest, textStatus, errorThrown) ->
          alert errorThrown
          if (xmlHttpRequest.readyState is 0) or (xmlHttpRequest.status is 0)
            alert 'Request is fail'
      })
  selChart 'tag0'



