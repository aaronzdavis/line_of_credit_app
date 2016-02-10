require 'rails_helper'

RSpec.describe LineOfCredit, type: :model do
  let(:line_of_credit) {
    LineOfCredit.new(balance: 1000, user: User.new(name: "Aaron Davis"))
  }

  it 'line_of_credit should be valid' do
    expect(line_of_credit).to be_valid
  end

  it 'is invalid without balance' do
    line_of_credit.balance = nil
    expect(line_of_credit).to be_invalid
  end

  it 'is invalid without user' do
    line_of_credit.user = nil
    expect(line_of_credit).to be_invalid
  end

  it 'calculates 30 day intrest and total payment' do
    # He draws 500$ on day one so his remaining credit limit is 500$ and his balance is 500$.
    # He pays back 200$ on day 15 and then draws another 100$ on day 25.  His total owed interest on
    # day 30 should be 500 * 0.35 / 365 * 15 + 300 * 0.35 / 365 * 10 + 400 * 0.35 / 365 * 5  which is
    # 11.99.  Total payment should be 411.99.

    payoff = 400 + (500 * 0.35 / 365 * 15) + (300 * 0.35 / 365 * 10) + (400 * 0.35 / 365 * 5).to_d

    line_of_credit.save
    line_of_credit.transactions << Transaction.new(transaction_type: :withdrawl, amount: 500)

    Timecop.freeze(Date.today + 15) do
      line_of_credit.transactions << Transaction.new(transaction_type: :deposit, amount: 200)
    end

    Timecop.freeze(Date.today + 25) do
      line_of_credit.transactions << Transaction.new(transaction_type: :withdrawl, amount: 100)
    end

    Timecop.freeze(Date.today + 30) do
      expect(line_of_credit.payoff_amount).to be_within(0.001).of(payoff)
    end
  end

end
