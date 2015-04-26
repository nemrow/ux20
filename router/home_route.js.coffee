Router.route '/',
  name: "home"
  action: ->
    if Meteor.user()
      Router.go('categories')
    else
      Router.go('login')

Router.route 'categories',
  name: "categories"
  action: ->
    if Meteor.user()
      @layout('mainLayout')
      @render('categories')
    else
      Router.go("login")

Router.route "subCategories",
  name: "subCategories"
  path: '/categories/:category'
  data: ->
    templateData = {
      subCategories: getSubCategories(@params.category)
    }
  action: ->
    if Meteor.user()
      @layout('mainLayout')
      @render('subCategories')

Router.route "record",
  name: "record"
  path: "/subCategories/:subCategory/record"
  data: ->
    templateData = {
      subCategory: subCategoriesList[@params.subCategory]
    }
  action: ->
    if Meteor.user()
      Session.set("placeTags", getTags(@params.subCategory))
      @layout('mainLayout')
      @render('record')
    else
      Router.go("login")

Router.route "review",
  name: "review"
  path: "/subCategory/:subCategory/review"
  data: ->
    templateData = {
      subCategory: subCategoriesList[@params.subCategory]
    }
  action: ->
    if Meteor.user()
      @layout('mainLayout')
      @render('review')
    else
      Router.go("login")

Router.route "search",
  name: "search"
  path: "/search/:searchId"
  data: ->
    @params
  action: ->
    if Meteor.user()
      @layout('mainLayout')
      @render('search')
    else
      Router.go("login")

Router.route '/login',
  name: "login"
  action: ->
    if Meteor.user()
      Router.go("home")
    else
      @layout('mainLayout')
      @render('login')

Router.route '/logout',
  name: "logout"
  action: ->
    Meteor.logout()
    Router.go('login')

