class TasksController < ApplicationController

  get '/tasks/new' do
    erb :'/tasks/new'
  end

  post '/tasks' do
    raise params.inspect
  end

  get '/tasks/:id' do

  end

end
