readData = (event) -> JSON.parse(event.data)
writeData = (data) -> socket.send(JSON.stringify(data))
log = (t) -> console.log(t)
currentDate = () -> (new Date()).toLocaleTimeString()


addMessage = (data,s) ->

  if s
    result = '<div class="self">' +
      '<div class="text">' + data.text + '</div>' +
      '<div class="person">' +
      '<img class="avatar" src="'+ gravatar(data.email) + '"/>' +
      '<span class="name">' + data.name + '</span>' +
      '</div>' +
      '<span class="time">' + currentDate() + '</span>' +
      '</div>'
  else
    result = '<div class="other">' +
      '<span class="time">' + currentDate() + '</span>' +
      '<div class="person">' +
      '<img class="avatar" src="'+ gravatar(data.email) + '"/>' +
      '<span class="name">' + data.name + '</span>' +
      '</div>' +
      '<div class="text">' + data.text + '</div>' +
      '</div>'
  $('#socketout').append(result)


$(document).ready(()->
  name = prompt('Enter your name:')
  email = prompt('Enter your email:')
  $('#avatar').attr('src',gravatar(email))

  socket.onmessage = (event) -> 
    data = readData(event)
    log('Recieved: '+data.text)
    addMessage(data,false)

  $('#form').submit(() ->
    text = $('#box').val()
    log('Sending: '+text)
    data = {name: name, email: email, text: text}
    addMessage(data,true)
    writeData(data)
    $('#box').val('')
    false
  )
)
