class User <  ActiveRecord::Base
    has_many :todolists
    has_secure_password
    validates :email, presence: true
    validates :email, uniqueness: true
    validates :password_digest, presence: true

end