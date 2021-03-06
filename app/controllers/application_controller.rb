require './config/environment'

class ApplicationController < Sinatra::Base

 
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions 
    register Sinatra::Flash
    set :session_secret, ENV['SESSION_SECRET']
    
  end

  get "/" do
    if logged_in?
      redirect '/todolists'
    else
    erb :welcome
    end
  end

  helpers do  #allows our views to access these methods 
    def logged_in?
        !!current_user #boolean 
    end

    def current_user   #memoization
       @current_user ||=  User.find(session[:user_id]) if session[:user_id]
    end
    
    def redirect_if_not_logged_in
      if !logged_in?
        flash[:message] = "Login required!"
        redirect '/login'
      end
    end
  end

  end



