class UserController < ApplicationController

    get '/signup' do
        erb :"users/new"
    end

    post '/signup' do
        user = User.new(email: params["email"], password: params["password"])
        if !user.save
        # if user.email == ""|| user.password == "" || User.find_by_email(params["email"])
            flash[:alert] = "Invalid email or password!"
            redirect '/signup'
        else
            # user.save
            session[:user_id] = user.id
            flash[:notice] = "Profile created successfully!"
            redirect '/todolists'
        end
    end

    get '/login' do #show the form
       if logged_in?
        flash[:message] = 'You have already logged in!'
        redirect '/todolists'
        end
            erb :"/users/login"
       
    end

    post '/login' do  #process the form 
        user = User.find_by(:email => params[:email])
        # check and see if there is a user w/ that email address
        # is there password correct
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id 
            flash[:notice] = "login successful!"
            redirect '/todolists'
        else
            flash[:alert] = "Invalid email or password!"
            redirect '/login'
        end
    end

    get '/logout' do 
        if logged_in?
        session.delete(:user_id)  # delete just the user_id 
        # session.clear 
        flash[:notice] = "You have successfully logged out!"
        redirect '/'
        else 
        flash[:message] = "You are not logged in!"
        redirect '/'
        end
    end

end