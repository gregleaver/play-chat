readData = (event) -> JSON.parse(event.data)
writeData = (data) -> socket.send(JSON.stringify(data))
log = (t) -> console.log(t)
currentDate = () -> (new Date()).toLocaleTimeString()


addMessage = (data,s) ->

  if s
    result = '<div class="self">' +
      '<span class="text">' + data.text + '</span>' +
      '<span class="name">' + data.name + '<span>' +
      '<span class="time">' + currentDate() + '</span>' +
      '</div>'
  else
    result = '<div class="other">' +
      '<span class="time">' + currentDate() + '</span>' +
      '<span class="name">' + data.name + '<span>' +
      '<span class="text">' + data.text + '</span>' +
      '</div>'
  $('#socketout').append(result)


$(document).ready(()->
  name = prompt('Enter your name:')

  socket.onmessage = (event) -> 
    data = readData(event)
    log('Recieved: '+data.text)
    addMessage(data,false)

  $('#form').submit(() ->
    text = $('#box').val()
    log('Sending: '+text)
    data = {name: name, text: text}
    addMessage(data,true)
    writeData(data)
    $('#box').val('')
    false
  )
)
