App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    if data.online_user
      if data.online_user.is_online
        notify "User " + data.online_user.username + " is online!"
      else
        notify "User " + data.online_user.username + " is offline!"
    alert(data.mention.text) if data.mention && data.mention.is_mention
    unless data.message.blank?
      $('#messages-table').append data.message

      #$('#messages').scrollTop($('#messages').prop('scrollHeight'));
      scroll_bottom()

$(document).on 'turbolinks:load', ->
  submit_message()
  scroll_bottom()

submit_message = () ->
  $('#message_content').on 'keydown', (event) ->
    if event.keyCode is 13 && !event.shiftKey
      # console.log(event)
      $('input').click()
      event.target.value = ""
      event.preventDefault()

scroll_bottom = () ->
  $('#messages').scrollTop($('#messages')[0].scrollHeight)

notify = (text) ->
  if Notification.permission == "granted"
    new Notification(text)
  else if Notification.permission != 'denied'
    Notification.requestPermission (permission) ->
      if permission == "granted"
        new Notification(text)

