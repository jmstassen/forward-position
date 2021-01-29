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

  get '/references/new' do
    if !logged_in?
      redirect '/'
    else
      erb :'/references/new'
    end
  end

  get '/references/:id/edit' do
    set_reference
    if logged_in?
      if user_owns?(@reference)
        erb :'/references/edit'
      else
        redirect '/references'
      end
    else
      redirect '/'
    end
  end

  patch '/references/:id' do
  
    set_reference
    if !logged_in?
      redirect '/'
    else
      if user_owns?(@reference)
        if params[:reference][:title] != ""
          @reference.update(params[:reference])
          @user = @reference.user
          @user.references << @reference
          redirect "/references/#{@reference.id}"
        else
          redirect '/references'
        end
      else
        redirect '/references'
      end
    end
  end

  get '/references/:id' do
    if Reference.exists?(params[:id])
      set_reference
      if user_owns?(@reference)
        @user = @reference.user
        erb :'/references/show'
      else
        redirect '/references'
      end
    else
      redirect '/references'
    end
  end
end

private

  def set_reference
    @reference = Reference.find(params[:id])
  end
