require 'rails_helper'

RSpec.describe "Articles", type: :request do
  let!(:user) { create(:user) }
  let!(:article) { create(:article, user: user) }

  shared_examples 'リクエストに成功すること' do
    example 'リクエストに成功すること' do
      expect(response).to have_http_status(:success)
    end
  end

  shared_examples 'サインイン画面へリダイレクトされること' do
    example 'サインイン画面へリダイレクトされること' do
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe '#index' do
    before { get articles_path }

    it_behaves_like 'リクエストに成功すること'
  end

  describe '#show' do
    before { get article_path(article.id) }

    it_behaves_like 'リクエストに成功すること'
  end

  describe '#new' do
    describe 'ログインしている時' do
      before do
        sign_in user
        get new_article_path
      end

      it_behaves_like 'リクエストに成功すること'
    end

    describe 'ログインしていない時' do
      before { get new_article_path }

      it_behaves_like 'サインイン画面へリダイレクトされること'
    end
  end

  describe '#create' do
    describe 'ログインしている時' do
      before { sign_in user }

      example '正常に作成できること' do
        expect do
          post articles_path, params: { article: { title: 'hoge', content: 'hoge' } }
        end.to change(Article, :count).by(1)
      end
    end

    describe 'ログインしていない時' do
      before { post articles_path, params: { article: { title: 'hoge', content: 'hoge' } } }

      it_behaves_like 'サインイン画面へリダイレクトされること'
    end
  end

  describe '#destroy' do
    describe 'ログインしている時' do
      context '本人の場合' do
        before { sign_in user }

        example '正常に削除できること' do
          expect { delete article_path(article.id) }.to change(Article, :count).by(-1)
        end
      end

      context '本人でない場合' do
        let!(:other_user) { create(:user) }

        before { sign_in other_user }

        example 'エラーが発生すること' do
          expect do
            delete article_path(article.id)
          end.to raise_error ActiveRecord::RecordNotFound
        end
      end
    end

    describe 'ログインしていない時' do
      before { delete article_path(article.id) }

      it_behaves_like 'サインイン画面へリダイレクトされること'
    end
  end

  describe '#update' do
    describe 'ログインしている時' do
      context '本人の場合' do
        before do
          sign_in user
          patch article_path(article.id), params: { article: { title: 'hoge', context: 'hoge' } }
        end

        example '正常に編集できること' do
          expect(response).to redirect_to article_path(article.id)
        end
      end

      context '本人でない場合' do
        let!(:other_user) { create(:user) }

        before { sign_in other_user }

        example 'エラーが発生すること' do
          expect do
            patch article_path(article.id), params: { article: { title: 'hoge', context: 'hoge' } }
          end.to raise_error ActiveRecord::RecordNotFound
        end
      end
    end

    describe 'ログインしていない時' do
      before do
        patch article_path(article.id), params: { article: { title: 'hoge', context: 'hoge' } }
      end

      it_behaves_like 'サインイン画面へリダイレクトされること'
    end
  end
end
