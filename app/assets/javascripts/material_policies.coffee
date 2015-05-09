# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

r = ->

  addChangeEvent = ->
    $(".paid").change ->
      $(@).parent().attr('data-override', $(@).is(':checked'))

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
    $('#material_policy_expire_date').val("#{day}-#{begin[1]}-#{year}")

  $('#material_policy_group_id').change ->
    group_id = $(@).val()
    $.get '/groups/'+group_id+'/items.json', (data) ->
      $('#material_policy_items').html ''
      $(data).each ->
        $('#material_policy_items').append($('<option>').text(@name).attr('value',@id))
      $('#material_policy_items').attr('disabled', false)

  addChangeEvent()

  $('.generate-installments').on 'input', ->
    count = parseInt($('#material_policy_inst').val())
    amount = parseInt($("#material_policy_contribution").val())/count
    $('input[name^="installments"]').remove()
    $('#installments tbody').html('')
    now = new Date()
    delta = 12/count
    console.log delta
    for i in [1..count]
      date = new Date(now.setMonth(now.getMonth() + delta*(i-1)))
      $('#installments tbody')
        .append('<tr><td>'+i+'</td><td>'+accounting.formatNumber(amount, 2, " ")+'</td><td>'+date.format('d-m-Y')+'
          </td><td data-override="false"><input type="checkbox" class="paid"></td></tr>')
    addChangeEvent()


  $('#new_material_policy, .edit_material_policy').submit (e) ->
    $('input[name="installments"]').remove();
    installments = $('#installments').tableToJSON
      ignoreColumns: [0]
      headings: ['amount', 'pay_date', 'paid']
    installments.shift()
    $(@).append('<input name="installments" type="hidden" value=\''+JSON.stringify(installments)+'\'>')
    alert JSON.stringify(installments)
    # e.preventDefault()
    # return false

    



$(document).ready(r)
$(document).on('page:load', r)