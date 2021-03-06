# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->

  # log hit event
  if $('#podcast-show-page').length
    url = document.location.pathname + '/count'
    $.post url, {event: 'hit'}

  # log download event
  $('.episode-download').on 'click', (e) ->
    url = document.location.pathname + '/count'
    $.post url, {event: 'download'}

  # log share(twitter) event
  twttr.ready (twttr) ->
    twttr.events.bind 'tweet', (event) ->
      if event.target.id == 'tweet-podcast'
        url = document.location.pathname + '/count'
        $.post url, event: 'share'
      return
    return

  # log share(facebook) event
  $('#share-podcast').on 'click', (e) ->
    FB.ui
      method: "share"
      href: $(this).data('url')
    , (response) ->
      if response && !response.error_message
        url = document.location.pathname + '/count'
        $.post url, event: 'share'
