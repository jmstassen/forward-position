class TasksController < ApplicationController

  get '/tasks' do
    @user = current_user
    erb :'/tasks/index'
  end

  get '/tasks/new' do
    if !logged_in?
      redirect '/'
    else
      erb :'/tasks/new'
    end
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
      if user_owns?(@task)
        erb :'/tasks/edit'
      else
        redirect '/tasks'
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
      if user_owns?(@task)
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
          redirect '/tasks'
        end
      else
        redirect '/tasks'
      end
    end
  end

  get '/tasks/:id' do
    set_task
    if user_owns?(@task)
      erb :'/tasks/show'
    else
      redirect '/tasks'
    end
  end

  private

    def set_task
      @task = Task.find(params[:id])
    end

end
