Template.record.helpers
  recording: ->
    Session.get("recordingInProgress")

  searchingPlaces: ->
    !Session.get("placesComplete")

  placesToCall: ->
    places = placesArray.map (place) -> place.name
    places.join(", ")

  uploadingRecording: ->
    Session.get("uploadRecordingInProgress")
