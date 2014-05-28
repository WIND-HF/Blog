class HomeController < ApplicationController
  def index
    @page_title = 'LittleKey'
  end

  def create
    @article = Article.new(article_param)

    @article.save
    redirect_to '/'
  end

  def new
  end

  def show
    @article = Article.find(params[:id])
    @page_title = @article.title
  end

  private
  def article_param
    params.require(:article).permit(:title, :text, :auth, :time)
  end
end
