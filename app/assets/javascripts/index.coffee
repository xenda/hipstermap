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
    name = photo.caption.text
    user = photo.caption.from.full_name
    user_pic = photo.caption.from.profile_picture
    latitude = photo.location.latitude
    longitude = photo.location.longitude
    console.log('An event was triggered with message: ' + url);
    map.addMarker
      lat: latitude
      lng: longitude
      click: (e) ->
        show_photo(url,name,user,user_pic)
    map.setCenter(latitude, longitude)
    show_photo(url, name, user, user_pic)

  show_photo = (url, name, user, user_pic) ->
    photo = $("#selected_photo")
    content = photo.find(".content")
    content.fadeOut 500, ->
      photo.find("h2[rel='photo_title']").html(name)
      photo.find("h3[rel='user']").text(user)
      photo.find("img[rel='user_pic']").attr("src",user_pic)
      photo.find("img[rel='image']").attr("src",url)
      setTimeout("content.fadeIn(500)", 1500)
