# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

r = ->
  $('#material_policy_client_id').select2()
  $('#material_policy_group_id').select2()
  $('#material_policy_items').select2()
  $('#material_policy_sign_date').datepicker
    format: "dd-mm-yyyy",
    language: 'pl'
  $('#material_policy_begin_date').datepicker
    format: "dd-mm-yyyy",
    language: 'pl'
  $('#material_policy_expire_date').datepicker
    format: "dd-mm-yyyy",
    language: 'pl'

  $('#material_policy_sign_date').change ->
    sign = $(@).val().split('-')
    day = (parseInt(sign[0],10) + 1).pad()
    $('#material_policy_begin_date').val("#{day}-#{sign[1]}-#{sign[2]}")
    $('#material_policy_begin_date').trigger 'change'

  $('#material_policy_begin_date').change ->
    begin = $(@).val().split('-')
    day = (parseInt(begin[0],10) - 1).pad()
    year = parseInt(begin[2],10) + 1
    console.log begin
    $('#material_policy_expire_date').val("#{day}-#{begin[1]}-#{year}")

  $('#material_policy_group_id').change ->
    group_id = $(@).val()
    $.get '/groups/'+group_id+'/items.json', (data) ->
      $('#material_policy_items').html ''
      $(data).each ->
        $('#material_policy_items').append($('<option>').text(@name).attr('value',@id))
      $('#material_policy_items').attr('disabled', false)

$(document).ready(r)
$(document).on('page:load', r)