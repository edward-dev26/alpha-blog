class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def show
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(get_article_data)
    @article.user = current_user

    if @article.save
      handle_save_success("Article was created successfully!")
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @article.update(get_article_data)
      handle_save_success("Article was updated successfully!")
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def get_article_data
    params.require(:article).permit(:title, :description)
  end

  def handle_save_success(message)
    flash[:notice] = message
    redirect_to @article
  end
end
