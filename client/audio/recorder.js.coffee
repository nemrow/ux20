class @Recorder
  constructor: (mediaStream) ->
    @mediaStream = mediaStream
    @recordRTC = RecordRTC(mediaStream)
    @uploader = new Slingshot.Upload("myFileUploads")
    @stopRecordingCallback = null

  beginRecording: ->
    Session.set("recordingInProgress", true)
    @recordRTC.startRecording()

  stopRecording: (stopRecordingCallback) ->
    @stopRecordingCallback = stopRecordingCallback
    Session.set("uploadRecordingInProgress", true)
    @recordRTC.stopRecording =>
      @uploadToS3()

  uploadToS3: ->
    @uploader.send @recordRTC.getBlob(), (error, downloadUrl) =>
      console.log downloadUrl
      @uploadComplete(downloadUrl)

  uploadComplete: (downloadUrl) ->
    @mediaStream.stop()
    recording = Recordings.insert
      userId: Meteor.userId()
      recordingUrl: downloadUrl
    Session.set("uploadRecordingInProgress", false)
    Session.set("recordingInProgress", false)
    Session.set("latestRecording", recording)
    @stopRecordingCallback()

