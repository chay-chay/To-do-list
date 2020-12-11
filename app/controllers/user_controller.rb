class UserController < ApplicationController

    get '/signup' do
        erb :"users/new"
    end

    post '/signup' do
        
        user = User.new(email: params["email"], password: params["password"])
        if user.email == ""|| user.password == "" || User.find_by_email(params["email"])
          
            redirect '/signup'
        else
            user.save
            session[:user_id] = user.id
            redirect '/todolists'
        end
    end

    get '/login' do #show the form
        erb :"/users/login"
    end

    post '/login' do  #process the form 
        user = User.find_by(:email => params[:email])
        # check and see if there is a user w/ that email address
        # is there password correct
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id 
            redirect '/todolists'
        else
            redirect 'users/login'
        end
    end

    get '/logout' do 
        session.delete(:user_id)  # delete just the user_id 
        # session.clear 
        redirect '/'

    end

end