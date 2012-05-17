class HomeController < ApplicationController
  
  def index
    #@initial = Instagram.geography_recent_media(123)
  end

  def callback
    Pusher.app_id = '20630'
    Pusher.key = 'c2663d1b5ca365fc8c20'
    Pusher.secret = '8cbbe7346e887830f9c7'

    results = params["_json"]
    photos = results.map do |result|
              Instagram.geography_recent_media(result["object_id"])
             end

    REDIS.sadd("instagram-photos",photos)
    Pusher['hipstermap'].trigger('photo:new', photos.to_json)
    render :text => params["hub.challenge"], :status => 202
  end

end