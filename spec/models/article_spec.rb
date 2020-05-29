require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'ファクトリー' do
    let(:article) { build(:article) }

    example '有効なファクトリを持つこと' do
      expect { article.save }.to change(Article, :count).by(1)
    end
  end

  describe 'バリデーション' do
    let(:article) { build(:article) }

    describe 'title' do
      subject { article.errors[:title] }

      example 'presence: true' do
        article.title = ''
        article.valid?
        is_expected.to include("can't be blank")
      end

      example 'length: { maximum: 100 }' do
        article.title = 'a' * 101
        article.valid?
        is_expected.to include("is too long (maximum is 100 characters)")
      end
    end

    describe 'content' do
      subject { article.errors[:content] }

      example 'presence: true' do
        article.content = ''
        article.valid?
        is_expected.to include("can't be blank")
      end

      example 'length: { maximum: 20000 }' do
        article.content = 'a' * 20001
        article.valid?
        is_expected.to include("is too long (maximum is 20000 characters)")
      end
    end
  end
end
