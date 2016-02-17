window.Views.Pages ||= {}

class Views.Pages.VenueView extends Views.ApplicationView
  render: ->
    super()

    ll = [39.9766392, -75.1342555]

    # center map on Front & Palmer
    map = L.map('venue-map', {
      scrollWheelZoom: false
    }).setView(ll, 14)

    # add base tile layer from MapBox
    L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpandmbXliNDBjZWd2M2x6bDk3c2ZtOTkifQ._QA7i5Mpkd_m30IGElHziw', {
      maxZoom: 18,
      attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
        '<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
        'Imagery © <a href="http://mapbox.com">Mapbox</a>',
      id: 'mapbox.streets'
    }).addTo(map)

    popup = $('#venue-popup').html()

    marker = L.marker(ll)
      .addTo(map)
      .bindPopup(popup)
      .openPopup()

  cleanup: ->
    super()
    # $('.venue-map').remove()