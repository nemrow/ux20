@placesArray = []
@searchRadius = 200

@Places = {
  run: ->
    Session.set("placesComplete", false)
    placesArray = []
    searchRadius = 200
    placesCount = 0
    navigator.geolocation.getCurrentPosition(
      Places.coordinatesSuccessHandler
      Places.coordinatesErrorHandler
      Places.mapOptions
    )

  coordinatesSuccessHandler: (coordinates) ->
    Session.set("coordinates", coordinates)
    Places.nearbySearch()

  mapOptions: {
    enableHighAccuracy: true
    timeout: 75000
    maximumAge: 3000
  }

  latLng: ->
    coordinates = Session.get("coordinates")
    new google.maps.LatLng coordinates.coords.latitude, coordinates.coords.longitude

  requestData: ->
    location: Places.latLng()
    radius: searchRadius
    opennow: true
    types: Session.get("placeTags")

  coordinatesErrorHandler: (coordinates) ->
    console.warn('ERROR(' + err.code + '): ' + err.message)

  placesService: ->
    new google.maps.places.PlacesService(Places.map())

  nearbySearch: ->
    Places.placesService().nearbySearch(Places.requestData(), Places.nearbySearchHandler)

  nearbySearchHandler: (results, status) ->
    if searchRadius > 4828 && results.length < 5
      # not enough spot around you
    # else if results.length < 12
    else if results.length < 6
      # increasing radius and running again
      setTimeout =>
        searchRadius += 200
        Places.nearbySearch()
      , 330
    else
      @placesCount = results.length
      Places.nearbySearchBatcher(results, 0)

  map: ->
    new google.maps.Map($('#map-node')[0], {center: Places.latLng(), zoom: 15})

  nearbySearchBatcher: (results, currentIndex) ->
    nextIndex = currentIndex + 5
    currentBatch = results.slice(currentIndex, nextIndex)
    for place in currentBatch
      Places.placesService().getDetails({placeId: place.place_id}, Places.placeDetailCallback)
    setTimeout ->
      Places.nearbySearchBatcher(results, nextIndex) if results[nextIndex] != undefined
    , 2000

  placeDetailCallback: (place, status) ->
    placesArray.push place if status == "OK"
    Places.placesSearchComplete() if --placesCount == 0

  placesSearchComplete: () ->
    Session.set("placesComplete", true)
}
