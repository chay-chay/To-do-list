class Todolist  <  ActiveRecord::Base
    belongs_to :user
    validates :todo,:date, :time, :description, presence: true
 

end