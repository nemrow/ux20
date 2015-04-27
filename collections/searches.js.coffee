@Searches = new Mongo.Collection("searches")

Searches.helpers
  transcribedResults: ->
    @places.filter (place) -> place.callSuccess

  waitingOnCalls: ->
    places = @places.filter (place) -> !place.callSuccess && !place.callFail
    console.log places.length
    places.length > 0

  params: ->
    {searchId: @_id}

  subCategoryName: ->
    subCategoriesList[@subCategory].name

  responseCount: ->
    places = @places.filter (place) -> place.callSuccess
    places.length

  noResultsFound: ->
    !@waitingOnCalls() && @responseCount() == 0
