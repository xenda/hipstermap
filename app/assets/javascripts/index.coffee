$(document).ready ->

  map = new GMaps
    div: '#map'
    lat: -12.043333
    lng: -77.028333

  pusher = new Pusher('c2663d1b5ca365fc8c20')
  channel = pusher.subscribe('hipstermap')
  channel.bind 'photo:new', (data)->
    process photo for photo in data

  process = (photo) ->
    console.log('An event was triggered with message: ' + photo.url);
    map.addMarker
      lat: photo.latitude
      lng: photo.longitude
      click: (e) ->
        show_photo(photo)
    map.setCenter(photo.latitude, photo.longitude)
    show_photo(photo)

  show_photo = (photo) ->
    photo_div = $("#selected_photo")
    content = photo_div.find(".content")
    content.fadeOut 500, ->
      photo_div.find("h2[rel='photo_title']").html(photo.name)
      photo_div.find("h3[rel='user']").text(photo.user)
      photo_div.find("img[rel='user_pic']").attr("src",photo.user_pic)
      photo_div.find("img[rel='image']").attr("src",photo.url)
      content.fadeIn(500)
