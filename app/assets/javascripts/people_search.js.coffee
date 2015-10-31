$(document).ready ->
  countPeople = (people) ->
    counts = {}
    for person in people
      counts[person.name.toLowerCase()] = (counts[person.name.toLowerCase()] || 0) + 1
    counts

  filterCounts = (counts) ->
    temp = {}
    for name, val of counts
      temp[name] = val if val > 1
    temp

  toRank = (count) ->
    "(" + romanize(count) + ")"

  romanize = (num) ->
    return false  unless +num
    digits = String(+num).split("")
    key = [ "", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM", "", "X",
      "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC", "", "I", "II", "III",
      "IV", "V", "VI", "VII", "VIII", "IX" ]
    roman = ""
    i = 3
    roman = (key[+digits.pop() + (i * 10)] or "") + roman  while i--
    Array(+digits.join("") + 1).join("M") + roman

  peopleFound = (connection, res) ->
    peopleTemplate = _.template($(".people-list.template").html())

    len = res.length
    res.push { name: connection.name, rank: "", podcasts: [] }
    counts = countPeople(res)
    counts = filterCounts(counts)

    for person in res by -1
      _name = person.name.toLowerCase()
      if counts[_name]
        person.rank = toRank(counts[_name])
        counts[_name] -= 1

    connection.rank = res.pop().rank

    data = for person, i in res
      temp = ""
      for podcast in person.podcasts
        temp += "<a href=\"#{podcast.url}\">#{podcast.name}</a>"
        temp += "<span>, </span>" if i < len
      person.podcasts = temp
      person

    sortedData = _.sortBy data, (person) -> [person.name, person.rank].join("_")
    $("div.people-form").hide()
    $("div.people-list").html(peopleTemplate({'people': sortedData, 'connection': connection}))

  noPeople = (connection) ->
    noPeopleTemplate = _.template($(".no-people.template").html())
    $("div.people-form").hide()
    $("div.people-list").html(noPeopleTemplate({'connection': connection}))

  $('#new_person_podcast').on 'submit', (e) ->
    e.preventDefault()

    connection =
      name:    $('#person_podcast_person_name').val()
      position: $('#person_podcast_position').val()
      podcast_name: $('#podcast-name').html().trim()
      doc_url: $('#person_podcast_doc_url').val()
      rank:    ""

    # Submit person search
    $.post '/people/search', { name: connection.name }, (res) ->
      if res.length > 0
        peopleFound(connection, res)
      else
        noPeople(connection)
