class User < ActiveRecord::Base
  has_many :lines_of_credits

  validates :name, presence: true

end
