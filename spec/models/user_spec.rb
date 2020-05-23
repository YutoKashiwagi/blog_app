require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ファクトリー' do
    let(:user) { build(:user) }

    example '有効なファクトリを持つこと' do
      expect { user.save }.to change(User, :count).by(1)
    end
  end

  describe 'バリデーション' do
    let(:user) { build(:user) }

    context 'name' do
      subject { user.errors[:name] }

      example 'presence: true' do
        user.name = ''
        user.valid?
        is_expected.to include("can't be blank")
      end

      example 'length: { maximum: 20 }' do
        user.name = 'a' * 21
        user.valid?
        is_expected.to include("is too long (maximum is 20 characters)")
      end
    end
  end
end
