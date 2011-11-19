readData = (event) -> JSON.parse(event.data)
writeData = (data) -> socket.send(JSON.stringify(data))
log = (t) -> console.log(t)
currentDate = () -> (new Date()).toLocaleTimeString()
scrollTo = (element) -> $(window).scrollTop(element.position().top)


addMessage = (data,s) ->

  if s
    result = '<div class="self">' +
      '<span class="time">' + currentDate() + '</span>' +
      '<div class="text">' + data.text + '</div>' +
      '<div class="person">' +
      '<img class="avatar" src="'+ gravatar(data.email) + '"/>' +
      '<span class="name">' + data.name + '</span>' +
      '</div>' +
      '</div>'
  else
    result = '<div class="other">' +
      '<div class="person">' +
      '<img class="avatar" src="'+ gravatar(data.email) + '"/>' +
      '<span class="name">' + data.name + '</span>' +
      '</div>' +
      '<div class="text">' + data.text + '</div>' +
      '<span class="time">' + currentDate() + '</span>' +
      '</div>'
  $('#socketout').append(result)
  scrollTo($('#text'))


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
