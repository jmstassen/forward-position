class UsersController < ApplicationController
  
  get '/login' do
    erb :login
  end

  post '/login' do
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tasks'
    else
      flash[:message] = "Invalid email/password combination. Please sign up or try again."
      redirect '/login'
    end
  end

  get '/signup' do
    erb :signup
  end 

  post '/users' do
    if params[:name] != "" && params[:email] != "" && params[:password] != ""
      @user = User.new(params)
      if @user.valid?
        @user.save
        session[:user_id] = @user.id
        flash[:message] = "You have signed up. Create a new task to get started."
        redirect '/tasks/new'
      else
        flash[:message] = "Invalid email/password combination. Please try again."
        redirect '/signup'
      end
    else
      flash[:message] = "All fields are required. Please try again."
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