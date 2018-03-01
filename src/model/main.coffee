if !localStorage['orderId']
#  setTimeout (() -> window.location = './order/order'), 5000

else
  delete localStorage['orderId']
#  window.location = './order/state'

$('.welcome_button').click ->
  window.location = './order/order'