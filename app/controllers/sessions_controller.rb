class SessionsController < ApplicationController

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

  get '/logout' do
    session.clear
    redirect '/'
  end

  get '/assistant/tasks' do
    if !logged_in?
      redirect '/'
    else
      @user = User.find_by(:assistant_email => current_user.email)
      @tasks = @user.tasks.select {|task| task.status == "active"}
      session[:assistant] = "yes"
      erb :'tasks/index'
    end
  end

  get '/assistant/references' do
    if !logged_in?
      redirect '/'
    else
      @user = User.find_by(:assistant_email => current_user.email)
      erb :'references/index'
    end
  end

  get '/exit-assistant' do
    session.delete(:assistant)
    redirect '/tasks'
  end

end
