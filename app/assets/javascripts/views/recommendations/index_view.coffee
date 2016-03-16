window.Views.Recommendations ||= {}

class Views.Recommendations.IndexView extends Views.ApplicationView
  map = null
  markers = []

  categoryIcon = (category) ->
    switch category
      when 'restaurant' then 'cutlery'
      when 'hotel' then 'bed'
      when 'home' then 'home'
      else 'map-marker'

  markerColor = (category) ->
    if category == 'home'
      'purple'
    else
      'blue'

  addMarker = (rec, index) ->
    ll = [rec.latitude, rec.longitude]

    icon = L.AwesomeMarkers.icon(
      icon: categoryIcon(rec.category)
      markerColor: markerColor(rec.category)
      prefix: 'fa'
    )

    marker = L.marker(ll, icon: icon)
      .addTo(map)
      .bindPopup("<div class='clearfix'><img class='thumbnail' src='#{rec.thumbnail}'><h5>#{rec.name} <small><a title='Get Directions' href='#{rec.google_maps_link}'>#{rec.address}</a></small></h5></div>")
    marker.index = index
    marker.on('click', clickMarker)
    markers.push(marker)
    
    marker

  recsLoaded = (recs) ->
    addMarker(r, i) for r, i in recs

  clickMarker = (e) ->
    $el = $(".recommendation[data-index=#{@index}]")
    scrollTop = $el.offset().top - 80
    $('html, body').animate({ scrollTop: scrollTop }, 500)

  overListItem = ->
    index = $(@).data('index')
    markers[index].openPopup()

  outListItem = ->
    index = $(@).data('index')
    markers[index].closePopup()

  render: ->
    super()

    # center map on Front & Palmer
    map = L.map('map', {
      scrollWheelZoom: false
    }).setView([39.9766392, -75.1342555], 13)

    # add base tile layer from MapBox
    L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpandmbXliNDBjZWd2M2x6bDk3c2ZtOTkifQ._QA7i5Mpkd_m30IGElHziw', {
      maxZoom: 18,
      attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
        '<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
        'Imagery © <a href="http://mapbox.com">Mapbox</a>',
      id: 'mapbox.streets'
    }).addTo(map)

    # draw markers
    addMarker(r, i) for r, i in RECOMMENDATIONS

    # attach hover event to recommendation list
    $('.recommendation').hover(overListItem, outListItem)

  cleanup: ->
    super()
    map = null
    markers = []
    delete window.RECOMMENDATIONS