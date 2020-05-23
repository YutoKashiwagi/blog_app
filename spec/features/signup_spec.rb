require 'rails_helper'

RSpec.feature "Signups", type: :feature do
  subject { Proc.new { click_button 'Sign up' } }

  before do
    visit new_user_registration_path
    fill_in 'Name', with: 'name'
    fill_in 'Email', with: 'email@email.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
  end

  example '正常にユーザー登録できること' do
    is_expected.to change(User, :count).by(1)
  end

  describe 'バリデーション' do
    describe 'name' do
      context '空白の場合' do
        example '失敗すること' do
          fill_in 'Name', with: ''
          is_expected.not_to change(User, :count)
        end
      end

      context '最大文字数より長い場合' do
        example '失敗すること' do
          fill_in 'Name', with: 'a' * 21
          is_expected.not_to change(User, :count)
        end
      end
    end
  end
end
