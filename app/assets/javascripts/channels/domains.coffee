# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Makes the user selected domain as current domain
$ ->
  flash = (html_markup) ->
    $('.flash-content').html(html_markup);
    $('.flash-content').fadeIn 'normal', ->
      $(this).delay(3000).fadeOut(2000)

  $(document).on 'change', '.js-set-domain', ->
    $.ajax
      url: $(this).data('url')
      type: 'POST'
      dataType: 'JSON'
      data:
        domain:
          id: $(this).data('domain-id')
      success: (data) ->
        if data.status
          html = '<div class="flash flash-success"><p class="notice">' + data.domain + ' has been made the current domain</p></div>'
          setTimeout (->
            location.reload()
          ), 1500
        else
          html = '<div class="flash flash-alert"><p class="alert">Something went wrong</p></div>'
        flash(html)
