jQuery(document).on 'turbolinks:load', ->
  online = $('#online')

  if online.length > 0
    createonlineChannel online.data('room-id') 


createonlineChannel = (roomId) ->
  App.online = App.cable.subscriptions.create {channel: "OnlineChannel", roomId: roomId},
    connected: ->
      # Called when the subscription is ready for use on the server
      console.log('Connected to onlineChannel')
    disconnected: ->
      # Called when the subscription has been terminated by the server
      console.log('Disconnected from onlineChannel')
    received: (data) ->
      # Called when there's incoming data on the websocket for this channel
      console.log('Received message: ' + data['online'])
      nickname = $('#' + data['nickname'])

      if nickname.length > 0
        nickname.replaceWith(data['online'])
      else
        $('#online').append data['online']

