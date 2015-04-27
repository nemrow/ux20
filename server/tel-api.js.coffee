Client = Meteor.npmRequire('telapi').client

client = new Client process.env.TEL_API_ACCOUNT_SID, process.env.TEL_API_AUTH_TOKEN

placeCall = (recipient, data) ->
  client.create(
    'calls',
    {
      From : '+14157636769'
      To   : recipient
      Url  : fullUrl("telApiInitCall", data)
      IfMachine: "hangup"
      StatusCallback: fullUrl("telApiStatusCallBack", data)
    },
    (response) ->
      console.log  JSON.stringify(response)
    ,
    (error) ->
      console.log ("Error: " + error)
  )

Meteor.startup ->
  Meteor.methods
    telApiInitPhoneCalls: (searchId) ->
      for place in Searches.findOne(searchId).places
        console.log place.phone_number
        placeCall "17078496085", {searchId: searchId, placeId: place.place_id}
        # placeCall place.phone_number, "searchId=#{searchId}&placeId=#{place.place_id}"
