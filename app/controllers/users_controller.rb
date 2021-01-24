class UsersController < ApplicationController
  
    #the purpose of this route is to render login page (form)
  get '/login' do
    erb :login
  end

  get '/signup' do
  end 


end