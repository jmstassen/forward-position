class AssistantsController < ApplicationController

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
      @references = @user.references.sort_by { |r| [r.title.downcase]}
      erb :'references/index'
    end
  end

  get '/exit-assistant' do
    session.delete(:assistant)
    redirect '/tasks'
  end
end