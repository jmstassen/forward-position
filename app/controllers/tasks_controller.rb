class TasksController < ApplicationController

  get '/tasks' do
    if !logged_in?
      redirect '/'
    else
      if session[:assistant] == "yes"
        redirect '/tasks/assistant'
      else      
        @user = current_user
        erb :'/tasks/index'
      end
    end
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
        redirect '/tasks'
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

  patch '/tasks/mass-update' do
    raise params.inspect
  end


  patch '/tasks/:id' do
    set_task
    if !logged_in?
      redirect '/'
    else
      if user_owns?(@task)
        if params[:task][:name] != ""
          @task.update(params[:task])
          @user = @task.user
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
            redirect '/tasks/:id'
        else
          redirect '/tasks/:id'
        end
      else
        redirect '/tasks/:id'
      end
    end
  end

  delete '/tasks/:id' do
    set_task
    if user_owns?(@task)
      @task.destroy
      redirect '/tasks'
    else
      redirect '/tasks'
    end
  end

  get '/tasks/:id' do
    if Task.exists?(params[:id])
      set_task
      if user_owns?(@task)
        @user = @task.user
        erb :'/tasks/show'
      else
        redirect '/tasks'
      end
    else
      redirect '/tasks'
    end
  end

  private

    def set_task
      @task = Task.find(params[:id])
    end

end
