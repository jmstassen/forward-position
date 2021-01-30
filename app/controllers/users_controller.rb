class UsersController < ApplicationController
  
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
      @user.update_attribute(:email, params[:user][:email])
      @user.update_attribute(:name, params[:user][:name])
      @user.update_attribute(:assistant_email, params[:user][:assistant_email])
      @user.update_attribute(:password, params[:new_password])
      redirect "/users/#{@user.id}"
    else
      redirect "/users/#{@user.id}"
    end
  end

end