require 'rails_helper'

RSpec.feature "Comments", type: :feature do
  let!(:user) { create(:user) }
  let!(:article) { create(:article) }

  describe '投稿' do
    before do
      sign_in user
      visit article_path(article.id)
      fill_in 'comment[content]', with: 'hoge'
    end

    describe '正常値' do
      example '正常に投稿できること' do
        expect { click_button '投稿' }.to change(Comment, :count).by(1)
      end
    end

    describe '異常値' do
      describe '空白の場合' do
        example '投稿に失敗すること' do
          fill_in 'comment[content]', with: ''
          click_button '投稿'
          expect(page).to have_content 'コメントの投稿に失敗しました'
        end
      end

      describe '1000文字より多い場合' do
        example '投稿に失敗すること' do
          fill_in 'comment[content]', with: 'a' * 1001
          click_button '投稿'
          expect(page).to have_content 'コメントの投稿に失敗しました'
        end
      end
    end
  end

  describe '削除' do
    let!(:comment) { create(:comment, article: article) }

    before do
      sign_in comment.user
      visit article_path(article.id)
    end

    example '正常に削除できること' do
      within ".comment_#{comment.id}" do
        expect do
          click_link '削除'
        end.to change(Comment, :count).by(-1)
      end
    end
  end
end
