require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "this_is_random_salt"
    register Sinatra::Flash
  end

  get '/' do
    if logged_in?
      redirect "/tasks"
    else
      erb :welcome
    end
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def user_owns?(object)
      object.user == current_user || current_user.email == object.user.assistant_email
    end
  end

end
