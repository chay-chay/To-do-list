class TodolistController < ApplicationController
#get all todolists - READ
get '/todolists' do 
    # display the index view 
    if !logged_in? 
        flash[:message] = "Login required!"
        redirect '/login' 
    end
    # @todo = Todolist.all # accessed the model 
    current_user.todolists
    erb :"todolists/index" 
end

# view the form to CREATE a todolist
get '/todolists/new' do 
    # display the new view 
     if !logged_in? 
        flash[:message] = "Login required!"
         redirect '/login'  #leave the method 
     else
    erb :"todolists/new"
     end
end

# get 1 todolist - READ
get '/todolists/:id' do
    
    redirect_if_not_logged_in
  
    @todo = Todolist.find(params["id"])
    erb :"todolists/show"
    # display the show view 
end

# CREATE a new todolist
post '/todolists' do 

    # todo = Todolist.new(todo: params[:todo])
    redirect_if_not_logged_in
    todo = current_user.todolists.build(params)
    todo.save 
    flash[:notice] = "Your list has been created!"
    redirect '/todolists' # makes a new GET request 
end

# view the form to UPDATE 1 particular movie
get '/todolists/:id/edit' do
    @todo = Todolist.find(params["id"])
    redirect_if_not_authorized
    erb :"todolists/edit"
end

# UPDATE 1 movie based on the edit form 
put '/todolists/:id' do
    @todo = Todolist.find(params["id"]) 
    redirect_if_not_authorized
   
   @todo.update(todo: params["todo"], date: params["date"])
   flash[:notice] = "Your list has been updated!"
    redirect "/todolists/#{@todo.id}"
end

delete '/todolists/:id' do 
    @todo = Todolist.find(params["id"])
    redirect_if_not_authorized
    @todo.destroy
    flash[:alert] ="Your list has been deleted!"
    redirect '/todolists'
end

private 
def redirect_if_not_authorized
    if @todo.user != current_user
        redirect '/todolists'
    end
end
end