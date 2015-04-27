Template.review.events
  "click .redo": ->
    history.back()

  "click #place-calls": ->
    currentSearch = Searches.insert
      userId: Meteor.userId()
      recording: Session.get("latestRecording")
      placeTags: Session.get("placeTags")
      subCategory: Session.get("subCategory")
      places: placesArray
      createdAt: new Date()

    Meteor.call 'twilioInitPhoneCalls', (currentSearch), (error, result) ->
      Session.set('searchingInProgress', false)
      Session.set('callingInProgress', true)
      Router.go("search", {searchId: currentSearch})
