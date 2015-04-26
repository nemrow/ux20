@toggleSession = (name) ->
  boolean = Session.get(name)
  Session.set(name, !boolean)
