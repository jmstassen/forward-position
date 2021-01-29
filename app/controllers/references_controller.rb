class ReferencesController < ApplicationController

  get '/references' do
    if !logged_in?
      redirect '/'
    else
      if session[:assistant] == "yes"
        redirect '/references/assistant'
      else      
        @user = current_user
        erb :'/references/index'
      end
    end
  end

end
