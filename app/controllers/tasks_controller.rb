class TasksController < ApplicationController

  get '/tasks' do
    if !logged_in?
      redirect '/'
    else
      if session[:assistant] == "yes"
        redirect '/assistant/tasks'
      else      
        @user = current_user
        @tasks = @user.tasks.select {|task| task.status == "active"}
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

  patch '/tasks/mass-update' do
    
    params[:tasks].each do |updates|
      @task = Task.find(updates[0].to_i)
      
      @task.update(:do_date => updates[1][:do_date].to_date)
      if updates[1][:status] == "done"
        @task.update(:status => "done")
        
      end
      if !updates[1][:content].empty?
        @task.notes << Note.create(content: updates[1][:content], user_id: current_user.id)
      end
    end
    redirect '/tasks'
  end

  post '/tasks' do    
    if !logged_in?
      redirect '/'
    else
      if params[:task][:name] != ""
        @task = Task.create(params[:task])
        @task.status = "active"
        if session[:assistant] == "yes"
          @user = User.find_by(:assistant_email => current_user.email)
        else
          @user = current_user
        end
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

  patch '/tasks/:id' do
    set_task
    if !logged_in?
      redirect '/'
    else
      if user_owns?(@task)
        if params[:task][:name] != ""
          binding.pry
          @task.update(params[:task])
          @user = @task.user
          @user.tasks << @task
          binding.pry
          @task.notes.each do |note|
              if params[:delete] != nil && params[:delete]["#{note.id}"] != nil
                note.delete
              else
                
                note.update(content: params[:note]["#{note.id}"])
                
              end
          end
          if !params[:note][:content].empty?
            @task.notes << Note.create(content: params[:note][:content], user_id: current_user.id)
          end
            redirect '/tasks'
        else
          redirect '/tasks'
        end
      else
        redirect '/tasks'
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

  get '/completed' do
    if !logged_in?
      redirect '/'
    else
      if session[:assistant] == "yes"
        @user = User.find_by(:assistant_email => current_user.email)
      else      
        @user = current_user
      end
      completed = @user.tasks.select {|task| task.status == "done"}
      @tasks = completed.sort_by { |t| t.updated_at }.reverse
      erb :'/tasks/completed'
    end
  end

  private

    def set_task
      @task = Task.find(params[:id])
    end

end


