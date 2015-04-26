Template.categories.helpers
  categories: ->
    categoryArray = []
    for key, val of categoriesList
      categoryArray.push val
    categoryArray
