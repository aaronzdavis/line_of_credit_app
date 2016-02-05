class Transaction < ActiveRecord::Base
  belongs_to :line_of_credit

  validates :transaction_type, :amount, :line_of_credit, presence: true

  enum transaction_type: [ :withdrawl, :deposit ]
end
