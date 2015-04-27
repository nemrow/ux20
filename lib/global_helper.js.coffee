@toggleSession = (name) ->
  boolean = Session.get(name)
  Session.set(name, !boolean)

@fullUrl = (path, data) ->
  base = "#{process.env.BASE_URL}/#{path}"

  if data
    paramsArray = Object.keys(data).map (object) ->
      "#{object}=#{data[object]}"
    console.log paramsArray
    "#{base}?#{paramsArray.join('&')}".replace("&","&amp;")
  else
    base.replace("&","&amp;")
