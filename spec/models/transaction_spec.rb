require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let(:transaction) {
    Transaction.new(transaction_type: :withdrawl, amount: 500, line_of_credit: LineOfCredit.new(balance: 1000, user: User.new(name: "Aaron Davis")))
  }

  let(:deposit) {
    Transaction.new(transaction_type: :deposit, amount: 500, line_of_credit: LineOfCredit.new(balance: 1000, user: User.new(name: "Aaron Davis")))
  }

  it 'transaction should be valid' do
    expect(transaction).to be_valid
  end

  it 'is invalid without amount' do
    transaction.amount = nil
    expect(transaction).to be_invalid
  end

  it 'is invalid without line_of_credit' do
    transaction.line_of_credit = nil
    expect(transaction).to be_invalid
  end

  it 'should reduce Line Of Credit balance when withdrawl transaction is created' do
    transaction.save
    expect(transaction.line_of_credit.balance).to eq(500)
  end

  it 'should increase Line Of Credit balance when deposit transaction is created' do
    deposit.save
    expect(deposit.line_of_credit.balance).to eq(1500)
  end

end
