# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on 'change', '.set-domain', ->
    $.ajax
      url: $(this).data('url')
      type: 'POST'
      dataType: 'JSON'
      data:
        domain:
          id: $(this).data('domain-id')
      success: (data) ->
        if data.status
          alert 'yay'
        else
          alert 'nay'
