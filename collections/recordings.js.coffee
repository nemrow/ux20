@Recordings = new Mongo.Collection("recordings")

Recordings.helpers
  isComplete: ->
    @status?

