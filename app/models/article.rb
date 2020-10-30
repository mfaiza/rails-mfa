class Article < ApplicationRecord
  belongs_to :user
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
