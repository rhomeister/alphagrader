return unless window.Notification
Notification.requestPermission()

App.messages = App.cable.subscriptions.create 'SubmissionsChannel',
  received: (data) ->
    notification = new Notification data.title,
      body: data.body

    notification.onclick = ->
      notification.close()
      window.location = data.url
      window.focus()
