requireLogin = ->
  if Meteor.user() || Meteor.loggingIn()
    @next()
  else
    Router.go('login')

Router.onBeforeAction requireLogin, { except: ['login'] }
