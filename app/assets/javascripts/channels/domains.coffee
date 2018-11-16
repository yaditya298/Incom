# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Makes the user selected domain as current domain
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
        debugger
        if data.status
          html = '<div class="flash flash-success"><p class="notice">' + data.domain + ' has been made the current domain</p></div>'
        else
          html = '<div class="flash flash-alert">Could not update the domain. Something went wrong<p class="alert"></p></div>'
        $('.flash-content').html html

