Template.home.helpers
  activeTags: ->
    tagsCollection.find({active: true})

  showResults: ->
    Session.get('showResults')
