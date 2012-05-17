$(document).ready ->

  map = new GMaps
    div: '#map'
    lat: -12.043333
    lng: -77.028333

  pusher = new Pusher('c2663d1b5ca365fc8c20')
  channel = pusher.subscribe('hipstermap')
  channel.bind 'photo:new', (data)->
    console.log('An event was triggered with message: ' + data.message);
