class Article < ApplicationRecord
  belongs_to :user
  has_many :article_categories
  has_many :categories, :through => :article_categories

  validates :title, presence: true, length: {minimum: 4, maximum: 25}
  validates :body, presence: true, length: {minimum: 4, maximum: 144}
  
  #   def self.search(search)
  #   	if search
	 #     	where("title LIKE ?", "%#{search}%")
		# else
		# 	Article.all
		# end
  #   end

end
