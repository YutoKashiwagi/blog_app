require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let!(:user) { create(:user) }
  let!(:article) { create(:article) }

  shared_examples 'サインイン画面へリダイレクトされること' do
    example 'サインイン画面へリダイレクトされること' do
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe '#create' do
    describe 'ログインしている場合' do
      before { sign_in user }

      example '正常に作成できること' do
        expect do
          post article_comments_path(article_id: article.id), params: { comment: { content: 'hoge' } }
        end.to change(Comment, :count).by(1)
      end
    end

    describe 'ログインしていないとき' do
      before { post article_comments_path(article_id: article.id), params: { comment: { content: 'hoge' } } }

      it_behaves_like 'サインイン画面へリダイレクトされること'
    end
  end

  describe '#destroy' do
    let!(:comment) { create(:comment) }

    describe 'ログインしているとき' do
      describe '本人の場合' do
        before { sign_in comment.user }

        example '正常に削除できること' do
          expect do
            delete comment_path(comment.id)
          end.to change(Comment, :count)
        end
      end

      describe '本人でない場合' do
        before { sign_in user }

        example '編集できないこと' do
          expect do
            delete comment_path(comment.id)
          end.to raise_error ActiveRecord::RecordNotFound
        end
      end
    end

    describe 'ログインしていないとき' do
      before { delete comment_path(comment.id) }

      it_behaves_like 'サインイン画面へリダイレクトされること'
    end
  end

  describe '#edit' do
    let!(:comment) { create(:comment) }

    describe 'ログインしているとき' do
      describe '本人の場合' do
        before { sign_in comment.user }

        example 'リクエストに成功すること' do
          get edit_comment_path(comment.id)
          expect(response).to have_http_status(:success)
        end
      end

      describe '本人でない場合' do
        before { sign_in user }

        example '編集できないこと' do
          expect do
            get edit_comment_path(comment.id)
          end.to raise_error ActiveRecord::RecordNotFound
        end
      end
    end

    describe 'ログインしていないとき' do
      before { get edit_comment_path(comment.id) }

      it_behaves_like 'サインイン画面へリダイレクトされること'
    end
  end

  describe '#update' do
    let!(:comment) { create(:comment) }

    describe 'ログインしているとき' do
      describe '本人の場合' do
        before { sign_in comment.user }

        example '正常に編集できること' do
          put comment_path(comment.id), params: { comment: { content: 'hoge' } }
          expect(response).to redirect_to article_path(comment.article.id)
        end
      end

      describe '本人でない場合' do
        before { sign_in user }

        example '編集できないこと' do
          expect do
            put comment_path(comment.id), params: { comment: { content: 'hoge' } }
          end.to raise_error ActiveRecord::RecordNotFound
        end
      end
    end

    describe 'ログインしていないとき' do
      before { put comment_path(comment.id), params: { comment: { content: 'hoge' } } }

      it_behaves_like 'サインイン画面へリダイレクトされること'
    end
  end
end
