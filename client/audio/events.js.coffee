recorder = null

Template.recordButton.events
  "click .record-btn": ->
    if Session.get("recordingInProgress")
      recorder.stopRecording()
    else
      navigator.getUserMedia_ {audio: true, video: false}, (mediaStream) ->
        recorder = new Recorder mediaStream
        recorder.beginRecording()
      , (e) -> console.log e
