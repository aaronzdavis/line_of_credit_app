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

end
