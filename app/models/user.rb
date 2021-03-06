class User < ApplicationRecord
    before_save { self.email = email.downcase }
    has_many :articles, dependent: :destroy
    validates :username, uniqueness: { case_sensitive: false }, 
                        presence: true, 
                        length: { minimun: 3, maximum: 25 }

        # Regex for email validation 
    # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    validates :email, uniqueness: { case_sensitive: false }, 
                    presence: true, 
                    length: { maximum: 105 },
                    format: { with: URI::MailTo::EMAIL_REGEXP } #Simple version hehe

    has_secure_password
end