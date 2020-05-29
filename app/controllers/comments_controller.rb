class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :create, :update, :destroy]
  before_action :set_comment, only: [:edit, :update, :destroy]

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new(comment_params)
    if @comment.save
      redirect_to article_path(@article.id), flash: { success: 'コメントを投稿しました' }
    else
      redirect_to article_path(@article.id), flash: { danger: 'コメントの投稿に失敗しました' }
    end
  end

  def destroy
    @comment.destroy
    redirect_to article_path(@comment.article.id), flash: { success: '記事を削除しました' }
  end

  def update
    @comment.update(comment_params)
    redirect_to article_path(@comment.article.id), flash: { success: 'コメントの編集に成功しました' }
  end

  def edit
  end

  private

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content).merge!(user_id: current_user.id)
  end
end
