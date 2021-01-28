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

end
