curOpeId = 1
curStatusId = 1
statusGap = 80
isMovingStatus = false
isMovingOpe = false
BaseUrl = 'http://p526.coil.sap.com:50004/MFGInno2/api/v1/orders'
topStart = 125
car_name = localStorage['carName']
imgsrc = localStorage['img']
operation = 1

getUrlParam = (name) ->
	reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)")
	r = window.location.search.substr(1).match reg
	if r isnt null
		return unescape r[2]
	return null

orderIdInUrl = getUrlParam 'orderId'
if(orderIdInUrl)
	order_id = orderIdInUrl
else
	order_id = localStorage['orderId']


$(document).ready ->
	moveToStatus = (statusId) ->
		curTop = topStart + (curStatusId - 1) * statusGap
		desTop = topStart + (statusId - 1) * statusGap
		if(statusId > 3)
			desTop += 50
		speedPerSec = 60
		timeInterval = 20
		isMovingStatus = true
		if(statusId is 5)
			desTop += 80
		moveTimer = setInterval (() ->
			curTop += (speedPerSec / 1000) * timeInterval
			$('.car').css('top', curTop + 'px')
#			$('#line-left').css('height', curTop + 'px')
#			$('#line-right').css('height', curTop + 'px')
			if(curTop >= desTop)
				curStatusId = statusId
				isMovingStatus = false
				clearInterval moveTimer
				if(4 is curStatusId)
					$('.car').css('-webkit-animation', 'spin-a 1s linear')
					setTimeout (() ->
						$('.car').css('-webkit-transform', 'rotate(-90deg)')
					), 950
				if(5 is curStatusId)
					$('.complete').toggleClass 'active'
		), timeInterval


	moveToOperation = (opeId) ->
		offsetPerc = 100 * (opeId - 1)
		speedPerSec = 50 * if opeId - curOpeId > 0 then 1 else -1
		curOffsetPerc = (curOpeId - 1) * 100
		timeInterval = 20
		isMovingOpe = true
		moveTimer = setInterval (() ->
			curOffsetPerc += (speedPerSec / 1000) * timeInterval
			$('.slides').css('right', curOffsetPerc + '%')
			if(speedPerSec > 0 && curOffsetPerc >= offsetPerc || speedPerSec < 0 && curOffsetPerc <= offsetPerc)
				curOpeId = opeId
				isMovingOpe = false
				clearInterval moveTimer
				if(10 is curOpeId)
					$('.car').css('-webkit-animation', 'spin 1s linear')
					setTimeout (() ->
						$('.car').css('-webkit-transform', 'rotate(0deg)')
					), 950
		), timeInterval

	findOrder = (BaseUrl, orderId) ->
		if !isMovingStatus and !isMovingOpe
			$.ajax({
				url: BaseUrl + '/' + orderId,
				type: "GET",
				dataType: "json",
				cache: false,
				async: true,
				crossDomain: true,
				success: (data) ->
					if data.orderId
						for i in [1..5]
								if Number data.status > i
									if $('#status' + i).hasClass 'ready'
										$('#status' + i).toggleClass 'ready completed'
									if $('#status' + i).hasClass 'onProcess'
										$('#status' + i).toggleClass 'onProcess completed'
								else
									if $('#status' + i).hasClass 'ready'
										$('#status' + i).toggleClass 'ready onProcess'
									break
						if data.status isnt curStatusId
							moveToStatus data.status
						if data.status is 4 and data.operationId isnt curOpeId
							moveToOperation data.operationId
				error: (xmlHttpRequest, textStatus, errorThrown) ->
					console.log errorThrown
			})
	$('#carimg').attr 'src', imgsrc
	$('#ctitle').text car_name
	$('#num').text 'No.' + order_id
	findOrder BaseUrl, order_id
	setInterval (() -> findOrder BaseUrl, order_id), 2000




