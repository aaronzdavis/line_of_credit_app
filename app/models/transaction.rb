class Transaction < ActiveRecord::Base
  belongs_to :line_of_credit

  validates :transaction_type, :amount, :line_of_credit, presence: true

  enum transaction_type: [ :withdrawl, :deposit ]

  scope :previous_30_days, ->{ where("transactions.created_at > ?", 30.days.ago) }

  after_create :update_balance
  def update_balance
    if self.withdrawl?
      self.line_of_credit.balance -= self.amount
    else
      self.line_of_credit.balance += self.amount
    end
    self.line_of_credit.save
  end
end
