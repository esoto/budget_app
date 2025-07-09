require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) do
    described_class.new(
      first_name: 'Example',
      last_name: 'Tester',
      email: 'example@test.com',
      password: 'password'
    )
  end

  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end

  it 'is invalid without a first name' do
    user.first_name = nil
    expect(user).not_to be_valid
  end

  it 'is invalid without a last name' do
    user.last_name = nil
    expect(user).not_to be_valid
  end

  it 'is invalid without an email' do
    user.email = nil
    expect(user).not_to be_valid
  end
end
