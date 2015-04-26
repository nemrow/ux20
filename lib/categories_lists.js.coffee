@categoriesList = {
  foodAndBeverage: {
    name: "Food and Beverage"
    image: "icon"
    category: "foodAndBeverage"
    subCategories: [
      "food"
      "grocery_or_supermarket"
      "liquor_store"
      "convenience_store"
    ]
  }
  drugs: {
    name: "Drugs"
    image: "icon"
    category: "drugs"
    subCategories: ["fastFood", ""]
  }
}

@subCategoriesList = {
  food: {
    name: "Food"
    tags: ["food"]
    subCategory: "food"
  }
  grocery_or_supermarket: {
    name: "Grocery or Supermarket"
    tags: ["grocery_or_supermarket"]
    subCategory: "grocery_or_supermarket"
  }
  liquor_store: {
    name: "Liquor Store"
    tags: ["liquor_store"]
    subCategory: "liquor_store"
  }
  convenience_store: {
    name: "Convenience Store"
    tags: ["convenience_store"]
    subCategory: "convenience_store"
  }
}

@getSubCategories = (category) ->
  categoriesList[category].subCategories.map (subCategory) ->
    subCategoriesList[subCategory]

@getTags = (subCategory) ->
  subCategoriesList[subCategory].tags
