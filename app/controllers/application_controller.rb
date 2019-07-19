
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
    article = Article.create(title: params[:title], content: params[:content])
    redirect "/articles/#{article.id}"
  end

  get '/articles/new' do
    erb :new
  end

  get '/articles/:id' do
    @article = Article.find(params[:id].to_i)
    erb :show
  end

  get '/articles/:id/edit' do
    @article = Article.find(params[:id].to_i)
    erb :edit
  end

  patch '/articles/:id' do
    article = Article.find(params[:id].to_i)
    article.update(title: params[:title], content: params[:content])
    redirect "/articles/#{article.id}"
  end

  delete '/articles/:id/delete' do
    Article.find(params[:id].to_i).destroy
  end
end
