# frozen_string_literal: true

require 'account'

RSpec.describe Account do
  context '#initialize' do
    it 'initializes with empty transactions array' do
      account = Account.new
      expect(account.transactions).to eq []
    end
  end
end
