class HomeController < ApplicationController
  
  def index
  end

  def callback
    Pusher.app_id = '20630'
    Pusher.key = 'c2663d1b5ca365fc8c20'
    Pusher.secret = '8cbbe7346e887830f9c7'
    Pusher['hipstermap'].trigger('photo:new', request.body)
    render :text => params["hub.challenge"], :status => 202
  end

end