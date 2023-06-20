# frozen_string_literal: true

require 'account'
require 'transaction'

RSpec.describe 'Account integration' do
  let(:account) { Account.new }

  context 'Account#add' do
    it 'adds a single transaction' do
      transaction = Transaction.new(100, '20-06-2023')
      account.add(transaction)

      expect(account.transactions).to eq [transaction]
    end

    it 'adds multiple transactions' do
      transaction1 = Transaction.new(100, '20-06-2023')
      transaction2 = Transaction.new(200, '21-06-2023')
      account.add(transaction1)
      account.add(transaction2)

      expect(account.transactions).to eq [transaction1, transaction2]
    end
  end
end
