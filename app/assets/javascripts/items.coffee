# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

r = ->
  $('#item_group_id').select2()

$(document).ready(r)
$(document).on('page:load', r)