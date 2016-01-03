$(document).ready ->
  # Create msg ajax callback
  $('body').on('ajax:success', '#new_message', (e, data, status, xhr) ->
      $("#compose").modal 'hide'
      if location.pathname.indexOf('profile') != -1
        $.getScript 'messages', ( data, textStatus, jqxhr ) ->
          $.notify 'Your message has been sent.'
      else
        $.notify 'Your message has been sent.'
     ).on "ajax:error", (e, xhr, status, error) ->
        $.notify {message: 'Something went wrong. Please try again.'}, {type: 'danger'}

  # Delete btn triger enabled/disabled
  $('body').on 'change', '#inbox input', ->
    if $('#inbox input:checked').length > 0
      $('#delete').prop('disabled', false)
    else
      $('#delete').prop('disabled', true)

  # Delete incomings
  $('body').on 'click', '#delete', ->
    ids = $.map($('#inbox input:checked'), (input) ->
      input.value
    )
    if (ids.length > 0)
      $.ajax
        url: '/incomings/delete_bunch'
        method: 'POST'
        dataType: 'json'
        data: {'_method': 'delete', 'ids': ids}
        success: (data, status, xhr) ->
          $.getScript('messages')
        error: (xhr, status, error) ->
          $.notify {message: 'Something went wrong. Please try again.'}, {type: 'danger'}

  # Keep the current tab active
  $('a[data-toggle="tab"]').on 'shown.bs.tab', (e) ->
    # save the latest tab; use cookies if you like 'em better:
    localStorage.setItem 'lastTab', $(this).attr('href')
    return
  # go to the latest tab, if it exists:
  lastTab = localStorage.getItem('lastTab')
  if lastTab
    $('[href="' + lastTab + '"]').tab 'show'
