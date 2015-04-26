Template.review.helpers
  recordingFinished: ->
    Session.get("recordingInProgress")

  recording: ->
    Recordings.findOne({_id: Session.get("latestRecording")})

  placesComplete: ->
    Session.get("placesComplete")
