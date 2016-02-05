class LineOfCredit < ActiveRecord::Base
  belongs_to :user

  validates :balance, :user, presence: true
end
