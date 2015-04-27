twilio = Twilio(process.env.TWILIO_SID, process.env.TWILIO_AUTH_TOKEN)

placeCall = (recipient, params) ->
  twilio.makeCall
    to: recipient
    from: '+14157636769'
    ifMachine: "Hangup"
    statusCallback: "#{process.env.BASE_URL}/twilio/statusCallback?#{params}"
    url: "#{process.env.BASE_URL}/twilio/initCall?#{params}"
  , (err, responseData) ->
    console.log responseData.from

Meteor.startup ->
  Meteor.methods
    twilioInitPhoneCalls: (searchId) ->
      for place in Searches.findOne(searchId).places
        # placeCall "17078496085", "searchId=#{searchId}&placeId=#{place.place_id}"
        placeCall place.formatted_phone_number, "searchId=#{searchId}&placeId=#{place.place_id}"
