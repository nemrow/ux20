Template.mySearches.helpers
  searches: ->
    Searches.find({userId: Meteor.userId()}, {sort: {createdAt: -1}})
