#= require jquery
#= require jquery_ujs
#= require twitter/bootstrap
#= require jquery-ui
#= require autocomplete-rails
#= require turbolinks
#= require_tree .


split = (val) ->
  val.split /,\s*/

extractLast = (term) ->
  split(term).pop()

$(document).ready ->
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
      false

fetchRecipes = (ingredients_list) ->
  $.get 'recipes', { ingredients: ingredients_list }, (data) ->
    updateRecipes(data)
    return
  return

appendIngredient = (name) ->
  $('#selected_ingredients > ul').append '<li id=' + name + '><a href><i class="fa fa-trash"></i></a> ' + name + '</li>'
  return