Template.navBar.helpers
  showBackButton: ->
    Router.current().route.getName() != "home"

Template.navBar.events
  'click .back-button': ->
    history.back()
