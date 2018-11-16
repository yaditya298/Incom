# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Method to fadeout the flash message
$ ->
  setTimeout (->
    $('.flash').fadeOut 'slow', ->
      $(this).fadeOut()
  ), 2000
  $('[data-toggle="tooltip"]').tooltip({ container: 'body' })

  $(document).on 'change', '.js-group-status', ->
    status = $(this).val()
    group_id = $(this).data('group-id')
    if confirm('You are about to make this group ' + $("#active_" + group_id + " option[value="+ $(this).val() + "]").text() + '. Continue?')
      $.ajax
        url: $(this).data('url')
        type: 'PUT'
        dataType: 'JSON'
        data:
          status: status
        success: (data) ->
          if data.success
            message = 'Group ' + data.name + ' has been made ' + status
            if status == 'true'
              window.location.reload()
              # $('.add_contacts_' + group_id).show()
              # button_markup = "<a class='btn btn-primary btn-sm add_contacts_" + group_id +  " data-toggle='modal' data-target='#add_contacts_" + group_id + " href='#'>Add Contacts</a>"
              # $('.js_add_toggle_' + group_id).html(button_markup)
            else if status == 'false'
              $('.js_add_toggle_' + group_id + ' a').remove()
          else
            message = 'Something went wrong'
