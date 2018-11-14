# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  add_connection = (group_id, contact_id, url) ->
    $.ajax
      url: url
      type: 'POST'
      dataType: 'JSON'
      data:
        group_id: group_id
        connection:
          contact_id: contact_id
      success: (data) ->
        if data.status == true
          alert('added')
        else
          alert('added already')

  destroy_connection = (url) ->
    $.ajax
      type: 'DELETE'
      url: url
      success: (data) ->
        if data.success
          alert 'Deleted'

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

  $('.connection-info').change ->
    group_id   = $(this).data('group-id')
    contact_id = $(this).data('contact-id')
    url        = $(this).data('url')
    check_url  = $(this).data('check-connection-url')
    if $(this).is(':checked') == true
      add_connection(group_id, contact_id, url)
    else if $(this).is(':checked') == false
      remove_connection(group_id, contact_id, check_url)
