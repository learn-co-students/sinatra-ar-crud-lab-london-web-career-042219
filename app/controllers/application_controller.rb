
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/articles' do 
    @articles = Article.all 
    erb :index
  end

  post '/articles' do 
    # binding.pry
    @article = Article.create(params["article"])
    redirect "/articles/#{@article.id}"
  end
  
  get '/articles/new' do
    erb :new
  end

  get '/articles/:id' do 
    @article = Article.find(params[:id])
    erb :show
  end

  #edit
  get '/articles/:id/edit' do
    #I need to find article by id in order to edit it and fill out that :id thing on the URL 
    @article = Article.find(params[:id])
    erb :edit
  end

  #update
  patch '/articles/:id' do
    article = Article.find(params[:id])
    article.update(params[:article])
    redirect "/articles/#{article.id}"
  end

  #delete
  delete '/articles/:id' do 
    Article.find(params[:id]).destroy
    redirect '/articles'
  end

end
