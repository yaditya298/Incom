# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on 'change', '.select_all', ->
    checked_value = $(this).is(':checked')
    group_id = $(this).data('group-id')
    $('#add_contacts_' + group_id + ' .connection-info').each ->
      $(this).prop('checked', checked_value)
    if $(this).is(':checked')
      $('.js_multi_submit').attr('disabled', false)
    else
      $('.js_multi_submit').attr('disabled', true)

  $(document).on 'change', '.connection-info', ->
    $('.js_multi_submit').attr('disabled', false)
    group_id = $(this).data('group-id')
    checked_count = $('#add_contacts_' + group_id + ' input:checked').length
    if $('#select_all_' + group_id).is(':checked')
      checked_count = checked_count - $('#select_all_' + group_id).length
    if checked_count == 0
      $('.js_multi_submit').attr('disabled', true)
    total_count = $('#add_contacts_' + group_id + ' .connection-info').length
    if checked_count != total_count
      $('#select_all_' + group_id).prop('checked', false)
    else if checked_count == total_count
      $('#select_all_' + group_id).prop('checked', true)

  $(document).on 'click', '.js_multi_submit', ->
    $('.modal .close').click()
