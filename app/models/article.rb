class Article < ApplicationRecord
    validates :title, presence: true, length: {minimum: 4, maximum: 25}
    validates :body, presence: true, length: {minimum: 4, maximum: 144}
end
