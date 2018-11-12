# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Method to fadeout the flash message
$ ->
  setTimeout (->
    $('.flash').fadeOut 'slow', ->
      $(this).remove()
  ), 1500
