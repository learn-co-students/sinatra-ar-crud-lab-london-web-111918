require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end


  #index
  get "/articles" do
    @articles = Article.all
    erb :"articles/index"
  end

  #create
  get "/articles/new" do
    erb :"articles/new"
  end

  post '/articles' do
    article = Article.create(title: params[:title], content: params[:content])
    redirect "articles/#{article.id}"
  end

 #show
  get "/articles/:id" do
    @article = Article.find(params[:id])
    erb :"/articles/show"
  end

  #update
  get "/articles/:id/edit" do
    @article = Article.find(params[:id])
    erb :"/articles/edit"
  end

  patch '/articles/:id' do
    article = Article.find(params[:id]).update(title: params[:title], content: params[:content])

    redirect "/articles/#{article.id}"
  end

  #destroy
  delete "/articles/:id" do
    article = Article.find(params[:id])
    article.destroy
    redirect "/articles"
  end

end
