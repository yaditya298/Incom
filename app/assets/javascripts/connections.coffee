# # Place all the behaviors and hooks related to the matching controller here.
# # All this logic will automatically be available in application.js.
# # You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  destroy_connection = (url) ->
    $.ajax
      type: 'DELETE'
      url: url
      success: (data) ->
        if data.success
          $('')
          $('.member_count_' + data.group_id).text data.members_count
          $('.member_count_' + data.group_id).effect 'highlight', 3000

  check_connection = (group_id, contact_id, check_url) ->
    $.ajax
      url: check_url
      type: 'GET'
      dataType: 'JSON'
      data:
        group_id: group_id
        contact_id: contact_id
      success: (data) ->
        if data.status
          destroy_connection(data.delete_connection_url, data.connection_id)

  remove_connection = (group_id, contact_id, check_url) ->
    check_connection(group_id, contact_id, check_url)

  $(document).on 'change', '.connection-info', ->
    group_id   = $(this).data('group-id')
    contact_id = $(this).data('contact-id')
    check_url  = $(this).data('check-connection-url')
    if $(this).is(':checked') == false
      remove_connection(group_id, contact_id, check_url)
