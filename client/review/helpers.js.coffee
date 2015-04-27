Template.review.helpers
  recordingFinished: ->
    Session.get("recordingInProgress")

  recording: ->
    Recordings.findOne({_id: Session.get("latestRecording")})

  placesComplete: ->
    Session.get("placesComplete") && !Session.get("notEnoughPlacesFound")

  notEnoughPlacesFound: ->
    Session.get("notEnoughPlacesFound")

  searchingPlaces: ->
    !Session.get("placesComplete") && !Session.get("notEnoughPlacesFound")
