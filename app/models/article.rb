class Article < ApplicationRecord
  belongs_to :user

  validates :title,   presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 20000 }
end
