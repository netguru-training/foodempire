#= require jquery
#= require jquery_ujs
#= require twitter/bootstrap
#= require jquery-ui
#= require autocomplete-rails
#= require turbolinks
#= require_tree .

availableTags = gon.ingredients

split = (val) ->
  val.split /,\s*/

extractLast = (term) ->
  split(term).pop()

$(document).ready ->
  $('#ingredients').bind('keydown', (event) ->
    if event.keyCode == $.ui.keyCode.TAB and $(this).autocomplete('instance').menu.active
      event.preventDefault()
  ).autocomplete
    minLength: 0
    source: (request, response) ->
      response $.ui.autocomplete.filter(availableTags, extractLast(request.term))
    focus: ->
      false
    select: (event, ui) ->
      terms = split(@value)
      terms.pop()
      terms.push ui.item.value
      terms.push ''
      @value = terms.join(', ')
      false
