recorder = null

Template.record.events
  "click #record": ->
    if Session.get("recordingInProgress")
      recorder.stopRecording =>
        Router.go("review", {subCategory: @subCategory.subCategory})
    else
      navigator.getUserMedia_ {audio: true, video: false}, (mediaStream) ->
        recorder = new Recorder mediaStream
        recorder.beginRecording()
      , (e) -> console.log e
