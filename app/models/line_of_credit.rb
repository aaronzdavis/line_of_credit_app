class LineOfCredit < ActiveRecord::Base
  belongs_to :user

  has_many :transactions

  validates :balance, :user, presence: true

  def payoff_amount
    withdrawn_amount = 0
    interest = 0

    transactions = self.transactions.previous_30_days
    transactions.each_with_index do |transaction, i|
      if transaction.withdrawl?
        withdrawn_amount += transaction.amount
      else
        withdrawn_amount -= transaction.amount
      end

      if next_transaction = transactions[i+1]
        days_at_this_balance = ((next_transaction.created_at - transaction.created_at) / 86400).round
      else
        days_at_this_balance = ((Time.now - transaction.created_at) / 86400).round
      end

      interest += withdrawn_amount * 0.35 / 365 * days_at_this_balance
    end
    return interest + withdrawn_amount
  end

end
