navigator.getUserMedia_ = (
  navigator.getUserMedia        ||
  navigator.webkitGetUserMedia  ||
  navigator.mozGetUserMedia     ||
  navigator.msGetUserMedia
)

Meteor.startup ->
  Session.set("recordingInProgress", false)
  GoogleMaps.load { v: '3', key: 'AIzaSyBQxflXcLzTmlImPvUj8DAn6FmF4SgIQxg', libraries: 'places' }
