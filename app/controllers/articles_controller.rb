class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_article, only: [:edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
    @comment = current_user.comments.new if current_user
    @comments = @article.comments
    @user = @article.user
  end

  def new
    @article = current_user.articles.new
  end

  def edit
  end

  def create
    @article = current_user.articles.new(article_params)
    if @article.save
      redirect_to article_path(@article.id), flash: { success: '記事を投稿しました' }
    else
      flash.now[:danger] = '記事の投稿に失敗しました'
      render action: :new
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path, flash: { success: '記事を削除しました' }
  end

  def update
    @article.update(article_params)
    redirect_to article_path(@article.id), flash: { success: '記事の編集に成功しました' }
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :article_image)
  end

  def set_article
    @article = current_user.articles.find(params[:id])
  end
end
