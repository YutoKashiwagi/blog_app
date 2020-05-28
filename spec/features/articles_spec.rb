require 'rails_helper'

RSpec.feature "Articles", type: :feature do
  let!(:user) { create(:user) }

  describe '新規作成' do
    before do
      sign_in user
      visit new_article_path
      fill_in 'article[title]', with: 'hoge'
      fill_in 'article[content]', with: 'hoge'
    end

    example '正常に作成できること' do
      expect do
        click_button '投稿'
      end.to change(Article, :count).by(1)
    end

    example 'エラーメッセージが表示されていること' do
      fill_in 'article[title]', with: ''
      fill_in 'article[content]', with: ''
      click_button '投稿'
      expect(page).to have_content "Title can't be blank"
      expect(page).to have_content "Content can't be blank"
    end
  end

  describe '編集' do
    let!(:article) { create(:article, user: user) }

    before do
      sign_in user
      visit edit_article_path(article.id)
      fill_in 'article[title]', with: 'hoge'
      fill_in 'article[content]', with: 'hoge'
    end

    example '正常に編集できること' do
      click_button '投稿'
      expect(page).to have_content '記事の編集に成功しました'
    end
  end
end
