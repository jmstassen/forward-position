class UsersController < ApplicationController
  
  get '/login' do
    erb :login
  end

  post '/login' do
    @user = User.find_by(email: params[:email])
    if !!@user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tasks'
    else
      redirect '/login'
    end
  end

  get '/signup' do
    erb :signup
  end 

  post '/users' do
    # need to make sure email is unique
    if params[:name] != "" && params[:email] != "" && params[:password] != ""
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect '/tasks'
    else
      redirect '/signup'
    end
  end

  get '/users/:id' do
    if !logged_in?
      redirect '/'
    else
      if current_user.id == params[:id].to_i
        @user = User.find_by(id: params[:id])
        erb :'/users/show'
      else
        redirect '/'
      end
    end
  end

  patch '/users/:id' do
    @user = User.find_by(id: params[:id])
    if @user.authenticate(params[:password])
      @user.email = params[:email]
      @user.update_attribute(:password, params[:new_password])
      redirect "/users/#{@user.id}"
    else
      redirect "/users/#{@user.id}"
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

end