require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'ファクトリー' do
    let(:comment) { build(:comment) }

    example '正常なファクトリを持つこと' do
      expect { comment.save }.to change(Comment, :count).by(1)
    end
  end

  describe 'バリデーション' do
    let!(:comment) { build(:comment) }

    describe 'content' do
      subject { comment.errors[:content] }

      example 'presence: true' do
        comment.content = ''
        comment.valid?
        is_expected.to include("can't be blank")
      end

      example 'length: { maximum: 1000 }' do
        comment.content = 'a' * 1001
        comment.valid?
        is_expected.to include("is too long (maximum is 1000 characters)")
      end
    end
  end

  describe 'アソシエーション' do
    describe '削除' do
      let!(:user) { create(:user) }
      let!(:article) { create(:article) }
      let!(:comment) { create(:comment, user: user, article: article) }

      example 'ユーザーに紐づいて削除されること' do
        expect { user.destroy }.to change(Comment, :count).by(-1)
      end

      example '記事に紐づいて削除されること' do
        expect { article.destroy }.to change(Comment, :count).by(-1)
      end
    end
  end
end
