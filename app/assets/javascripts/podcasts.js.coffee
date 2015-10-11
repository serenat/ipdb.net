# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->

  if $('#podcast-show-page').length
    url = document.location.pathname + '/count'
    $.post url, {event: 'hit'}

  $('.episode-download').on 'click', (e) ->
    url = document.location.pathname + '/count'
    $.post url, {event: 'download'}
