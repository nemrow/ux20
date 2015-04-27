Router.route '/telApiInitCall',
  where: 'server'
  action: ->
    xml = new InboundXML.Response()
    xml.append(
      new InboundXML.Play(
        "https://s3-us-west-2.amazonaws.com/find-it/Voice%2B012_Voice%2B012_generic.mp3"
      )
    )
    xml.append(
      new InboundXML.Record(
        {
          action: fullUrl('telApiHandleResponse')
          method : 'POST'
          timeout : 2
          transcribe: true
          background : false
          transcribeCallback: fullUrl('telApiTransribeHandler')
        }
      )
    )
    xml.append(
      new InboundXML.Say(
        'This message was send to a few places in your area. Your response will be sent to the customer.',
        {voice: 'woman'}
      )
    )

    console.log xml.toString()
    @response.writeHead(200, {'Content-Type': 'application/xml'});
    @response.write(xml.toString())
    @response.end()

Router.route "telApiTransribeHandler",
  where: 'server'
  action: ->
    console.log "TRANSCRIBE"
    console.log @params.query
    console.log @request.body

Router.route 'telApiHandleResponse',
  where: 'server'
  action: ->
    xml = new InboundXML.Response()
    xml.append(
      new InboundXML.Say(
        'Thanks!'
        {voice: 'woman'}
      )
    )
    @response.writeHead(200, {'Content-Type': 'application/xml'});
    @response.write(xml.toString())
    @response.end()

Router.route '/telApiStatusCallBack',
  where: 'server'
  action: ->
    debugger
    console.log @request.body
    console.log @params.query
    @response.end()
