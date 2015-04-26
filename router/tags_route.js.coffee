Router.route '/tags',
  name: "tags"
  action: ->
    @layout('mainLayout')
    @render('tags')
