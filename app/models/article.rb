class Article < ApplicationRecord
  belongs_to :user

  mount_uploader :article_image, ArticleImageUploader

  validates :title,   presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 20000 }
end
