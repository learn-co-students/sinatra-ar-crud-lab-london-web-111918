
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do
    erb :new
  end

  get '/articles/:id/edit' do
    @article = Article.find(params["id"].to_i)
    erb :edit
  end

  get '/articles/:id' do
    @article = Article.find(params["id"].to_i)
    erb :show
  end

  patch "/articles/:id" do
    @article = Article.find(params[:id])
    @article.update(title: params["title"], content: params["content"])
    redirect "/articles/#{@article.id}"
  end

  delete '/articles/:id' do
    @article = Article.find(params["id"])
    Article.delete(@article.id.to_i)
    redirect "/"
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  post '/articles' do
    Article.create(title: params['title'],  content: params['content'])
    redirect "/articles/#{Article.last.id}"
  end

end
