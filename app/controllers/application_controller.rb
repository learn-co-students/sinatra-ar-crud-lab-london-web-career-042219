
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  # index
  get '/articles' do
    @articles = Article.all
    erb :'articles/index'
  end

  # new
  get '/articles/new' do
    erb :'articles/new'
  end

   # show
   get '/articles/:id' do
     @article = Article.find(params[:id])
     erb :'articles/show'
   end

   # create
   post '/articles' do
     article = Article.create params[:article]
     redirect "/articles/#{article.id}"
   end

  # edit
  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :'articles/edit'
  end

  # update
  patch '/articles/:id' do
    article = Article.find(params[:id])
    article.update(params[:article])
    redirect "/articles/#{article.id}"
  end

  # delete
  delete '/articles/:id' do
    Article.find(params[:id]).destroy
    redirect '/articles'
  end
end
