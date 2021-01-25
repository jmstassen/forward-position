class TasksController < ApplicationController

  get '/tasks/new' do
    erb :'/tasks/new'
  end

  post '/tasks' do    
    if !logged_in?
      redirect '/'
    else
      if params[:task][:name] != ""
        @task = Task.create(params[:task])
        @user = User.find(current_user.id)
        @user.tasks << @task
        if !params[:note][:content].empty?
          @task.notes << Note.create(content: params[:note][:content], user_id: current_user.id)
        end
        redirect "/users/#{@user.id}"
      else
        redirect '/tasks/new'
      end
    end
  end

  get '/tasks/:id/edit' do
    set_task
    if logged_in?
      if @task.user == current_user
        erb :'/tasks/edit'
      else
        redirect "/users/#{current_user.id}"
      end
    else
      redirect '/'
    end
  end

  patch '/tasks/:id' do
    # need to prevent from editing other's
    set_task
    if !logged_in?
      redirect '/'
    else
      if params[:task][:name] != ""
        @task.update(params[:task])
        @user = User.find(current_user.id)
        @user.tasks << @task
        @task.notes.each do |note|
          @note = note
            if params[:delete] != nil
              if params[:delete]["#{@note.id}"] != nil
                @note.delete
              end
            else
              @note.update(content: params[:note]["#{@note.id}"])
            end
        end
        if !params[:note][:content].empty?
          @task.notes << Note.create(content: params[:note][:content], user_id: current_user.id)
        end
          redirect "/users/#{@user.id}"
      else
        redirect '/tasks/new'
      end
    end
  end

  get '/tasks/:id' do
    # need to prevent from seeing other's
    set_task
    erb :'/tasks/show'
  end

  private

    def set_task
      @task = Task.find(params[:id])
    end

end
