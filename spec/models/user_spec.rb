require 'rails_helper'

RSpec.describe User, type: :model do

  it 'is invalid without name' do
    user = User.new(name: nil)
    expect(user).to be_invalid
  end

end
