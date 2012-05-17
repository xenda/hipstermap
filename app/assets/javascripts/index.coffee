$(document).ready ->

  map = new GMaps
    div: '#map'
    lat: -12.043333
    lng: -77.028333

  pusher = new Pusher('c2663d1b5ca365fc8c20')
  channel = pusher.subscribe('hipstermap')
  channel.bind 'photo:new', (data)->
    photos = data[0]
    process photo for photo in photos


  process = (photo) ->
    url = photo.images.standard_resolution.url
    name = photo.caption
    latitude = photo.location.latitude
    longitude = photo.location.longitude
    console.log('An event was triggered with message: ' + url);
    map.addMarker
      lat: latitude
      lng: longitude
      infoWindow:
        content: '<img src="' + url + '"/>'
      click: (e) ->
        alert(name)
    map.setCenter(latitude, longitude)
