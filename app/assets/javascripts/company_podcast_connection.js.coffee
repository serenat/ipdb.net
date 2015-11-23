$(document).ready ->
  submitCompanyPodcast = (url, input, id) ->
    $.ajax
      url: url
      method: 'POST'
      dataType: 'json'
      data: {"company_podcast": { "podcast_id": id }}
      success: (data) ->
        $(input).prop('disabled', true)
        $(input).parents('tr').children('td:last').append('<span class="label label-info">permit approval</label>')
        if $('div.flash-msg').length == 0
          $('body').prepend('<div class="alert alert-info flash-msg">Thank you for submiting your connection. It is currently being proccesed. Please allow 1-2 weeks for your connections to be verified.</div>')

  $('#new_company_podcast').on 'submit', (e) ->
    e.preventDefault()

    selected = []
    $('#new_company_podcast input:checked:not(:disabled)').each ->
      selected.push $(this)

    if selected.length > 0
      url = $('#new_company_podcast').attr('action');
      for input in selected
        id = $(input).attr('value')
        temp = submitCompanyPodcast(url, input, id)
