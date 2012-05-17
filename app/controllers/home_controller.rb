class HomeController < ApplicationController
  
  def index
    data = REDIS.zrevrange("instagram-photo-colection", 0, 10)
    logger.info data.size
    @photos = data.map {|a| JSON.parse(a) }.flatten
  end

  def callback
    Pusher.app_id = '20630'
    Pusher.key = 'c2663d1b5ca365fc8c20'
    Pusher.secret = '8cbbe7346e887830f9c7'

    results = params["_json"]
    photos = results.map do |result|
              Instagram.geography_recent_media(result["object_id"])
             end

    photos_data = clean_photos(photos)

    REDIS.zadd("instagram-photo-colection",0,photos_data.to_json)
    Pusher['hipstermap'].trigger('photo:new', photos_data.to_json)
    render :text => params["hub.challenge"], :status => 202
  end

  def clean_photos(photos)
    data = photos[0]
    data.map {|photo|
      {
        :url => photo["images"]["standard_resolution"]["url"],
        :name => (photo["caption"] ? photo["caption"]["text"] : "" ),
        :user => photo["user"]["full_name"],
        :user_pic => photo["user"]["profile_picture"],
        :latitude => photo["location"]["latitude"],
        :longitude => photo["location"]["longitude"],
        :link => photo["link"],
        :created_at => photo["created_time"]
      }
    }
  end

end