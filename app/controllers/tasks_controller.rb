class TasksController < ApplicationController

  get '/tasks/new' do
    erb :'/tasks/new'
  end

  post '/tasks' do
    # create a new task and save it to the db
    # create a new note and save it to the db
    # make sure task and note have all necessary attributes
    # make sure task and note are only created if user is logged in
    
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



    # {"task"=>
    # {"name"=>"This is a whole new task", 
    # "due_date"=>"2021-01-28", 
    # "do_date"=>"2021-01-27", 
    # "category"=>"fyi", 
    # "size"=>"5", 
    # "note"=>{"content"=>"here is a new note within a task"}}}
  end

  get '/tasks/:id/edit' do
    set_task
    erb :'/tasks/edit'
  end

  patch '/tasks/:id' do
    set_task
    #find task
    #update task
    #find notes
    #update notes (delete if "on")
    #create new note (if applicable)
    #redirect to show page
    if !logged_in?
      redirect '/'
    else
      if params[:task][:name] != ""
        



        @task = Task.update(params[:task])
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

  

    # delete_note_9	
    # "on"
    # note	
    # {"9"=>"note #1 (John)", "content"=>"new note for it too"}
    # task	
    # {"name"=>"here's another new task for John - edited", 
    # "due_date"=>"2021-01-28", 
    # "do_date"=>"2021-01-28", 
    # "category"=>"fyi", 
    # "size"=>"3"}
  end



  get '/tasks/:id' do
    set_task
    erb :'/tasks/show'
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end


end
