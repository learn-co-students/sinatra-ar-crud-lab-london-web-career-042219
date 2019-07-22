require_relative '../../config/environment'
# Explanatory Comment
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/articles/new' do
    erb :new
  end

  get '/articles' do # DONE
    # This action should use Active Record to grab all of the
    # articles and store them in an instance variable, @articlesA
    @articles = Article.all
    erb :index
  end

  post '/articles' do # DONE
    new_one = Article.find_or_create_by(params['article'])
    @articles = Article.all
    redirect "/articles/#{new_one.id}"
  end

  get '/articles/:id' do # DONE
    # This action should use Active Record to grab the article with the id that is in the params and set it equal to @article.
    # Then, it should render the show.erb view page.
    # That view should use ERB to render the @article's title and content.
    @article = Article.find_by(id: params['id'])
    erb :show
  end

  # The Update CRUD action corresponds to the edit controller action and view
  get '/articles/:id/edit' do
    @article = Article.find_by(id: params['id'])
    erb :edit
  end

  patch '/articles/:id' do
    # binding.pry
    # {"_method"=>"PATCH", "article"=>{"title"=>"Dave", "content"=>"Why"}, "id"=>":id"}
    edit = params['article']
    @article = Article.find(params[:id])
    @article.update(edit)
    redirect :"/articles/#{@article.id}" # Interpolation req double quotes!
  end

  delete '/articles/:id' do
    # binding.pry
    del = Article.find(params['id'])
    del.destroy
    redirect :'/articles'
  end
end
