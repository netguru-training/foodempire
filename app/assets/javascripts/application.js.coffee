#= require jquery
#= require jquery_ujs
#= require twitter/bootstrap
#= require jquery-ui
#= require autocomplete-rails
#= require_tree .
#= require js-routes

split = (val) ->
  val.split /,\s*/

extractLast = (term) ->
  split(term).pop()

$(document).ready ->
  fetchRecipes()
  ingredients = gon.ingredients
  source = []
  mapping = {}
  i = 0
  while i < ingredients.length
    source.push ingredients[i].label
    mapping[ingredients[i].label] = ingredients[i].value
    ++i

  ingredients_list = []
  $('#ingredients').bind('keydown', (event) ->
    if event.keyCode == $.ui.keyCode.TAB and $(this).autocomplete('instance').menu.active
      event.preventDefault()
  ).autocomplete
    minLength: 0
    source: source
    focus: ->
      true
    select: (event, ui) ->
      if ingredients_list.indexOf(ui.item.value) == -1
        ingredients_list.push(mapping[ui.item.value])
        appendIngredient(ui.item.value)
        $('#ingredients').val ''
        fetchRecipes(ingredients_list)
        event.preventDefault()
      false

fetchRecipes = (ingredients_list) ->
  $.get 'recipes.json', { ingredients: ingredients_list }, (data) ->
    $('#recipes').empty()
    $.each data, (i, item) ->
      recipe = '<article><h3><a href="' + item['recipe_url'] + '">' + item['name'] + '</a></h3>'
      recipe += '<a href="' + item['recipe_url'] + '">'
      recipe += '<img  src="' + item['picture_url'] + '"></img></a>'
      recipe += '<div>'
      $.each item['ingredients'], (nr, ingredient) ->
        recipe += '<a href="' + Routes.ingredient_path(ingredient['id'])+'">' + ingredient['name'] + '</a>';
        if nr + 1 != item['ingredients'].length
          recipe += ', '
      recipe += '</div>'
      recipe += '</article>'
      $('#recipes').append recipe
      return
    return
  return

appendIngredient = (name) ->
  $('#selected_ingredients > ul').append '<li id=' + name + '><a href><i class="fa fa-trash"></i></a> ' + name + '</li>'
  return