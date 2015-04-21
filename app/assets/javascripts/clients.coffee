# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



r = ->
  $('.activity-switcher input').click ->
    unless $(@).hasClass('checked')
      $('.activity-switcher input').toggleClass 'checked'
      $('.pesel').toggleClass 'hide'
      $('.company').toggleClass 'hide'
      $('.regon').toggleClass 'hide'

$(document).ready(r)
$(document).on('page:load', r)