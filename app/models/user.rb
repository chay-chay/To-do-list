class User <  ActiveRecord::Base
    has_many :todolists

    has_secure_password

end