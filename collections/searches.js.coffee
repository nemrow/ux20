@Searches = new Mongo.Collection("searches")

Searches.helpers
  transcribedResults: ->
    @places.filter (place) -> place.callSuccess

  waitingOnCalls: ->
    places = @places.filter (place) -> !place.callSuccess && !place.callFail
    console.log places.length
    places.length > 0
