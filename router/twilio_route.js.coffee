Router.route '/twilio/statusCallback',
  where: 'server'
  name: 'twilioStatusCallback'
  action: ->
    console.log @request.body
    if @request.body.AnsweredBy != "human"
      searchObject = Searches.findOne(@params.query.searchId)
      placeObject = (i for i in searchObject.places when i.place_id is @params.query.placeId)[0]
      placeObject["status"] = "NO ANSWER"
      placeObject["callFail"] = true
      Searches.update
        '_id': @params.query.searchId
        'places.place_id': @params.query.placeId
        ,
          $set:
            'places.$': placeObject
    @response.end()

Router.route '/twilio/initCall',
  where: 'server'
  name: 'twilioInitCall'
  action: ->
    search = Searches.findOne(@params.query.searchId)
    recordingUrl = Recordings.findOne(search.recording).recordingUrl
    transcribeCallbackUrl = fullUrl "twilio/transcribe", {searchId: search._id, placeId: @params.query.placeId}
    thankYouCallbackUrl = fullUrl "twilio/thankYou", {searchId: search._id, placeId: @params.query.placeId}
    xmlData = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
    xmlData += "<Response>";
    # xmlData += "<Play>https://s3-us-west-2.amazonaws.com/find-it/Voice%2B012_Voice%2B012_generic.mp3</Play>";
    xmlData += "<Play>#{recordingUrl}</Play>";
    xmlData += "<Record trim='do-not-trim' timeout='3' transcribe='true' playBeep='false' action='#{thankYouCallbackUrl}' transcribeCallback='#{transcribeCallbackUrl}'/>"
    xmlData += "<Say>Thank you.</Say>"
    xmlData += "<Hangup/>"
    xmlData += "</Response>";
    @response.writeHead(200, {'Content-Type': 'application/xml'});
    @response.write(xmlData)
    @response.end()

Router.route '/twilio/thankYou',
  where: 'server'
  name: 'twilioThankYou'
  action: ->
    xmlData = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
    xmlData += "<Response>";
    xmlData += "<Say>Thank you.</Say>"
    xmlData += "<Hangup/>"
    xmlData += "</Response>";
    @response.writeHead(200, {'Content-Type': 'application/xml'});
    @response.write(xmlData)
    @response.end()

Router.route '/twilio/transcribe',
  where: 'server'
  name: 'twilioTranscribe'
  action: ->
    searchObject = Searches.findOne(@params.query.searchId)
    placeObject = (i for i in searchObject.places when i.place_id is @params.query.placeId)[0]
    placeObject["transcription"] = @request.body.TranscriptionText
    placeObject["status"] = "ANSWER"
    placeObject["callSuccess"] = true
    Searches.update
      '_id': @params.query.searchId
      'places.place_id': @params.query.placeId
      ,
        $set:
          'places.$': placeObject
    @response.end()
