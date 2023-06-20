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
      transaction1 = Transaction.new(200, '21-06-2023')
      transaction2 = Transaction.new(100, '20-06-2023')
      account.add(transaction1)
      account.add(transaction2)

      expect(account.transactions).to eq [transaction1, transaction2]
    end

    it 'sorts the array in place as transactions are added out-of-sequence' do
      transaction1 = Transaction.new(100, '20-06-2023')
      transaction2 = Transaction.new(200, '21-06-2023')
      transaction3 = Transaction.new(200, '22-06-2023')
      account.add(transaction1)
      account.add(transaction2)
      account.add(transaction3)

      expect(account.transactions).to eq [transaction3, transaction2, transaction1]
    end
  end

  context 'Account#calculate_balances' do
    it 'sets the balance of the first transaction correctly' do
      transaction = Transaction.new(100, '20-06-2023')
      account.add(transaction)
      account.calculate_balances

      first_transaction = account.transactions[0]
      expect(first_transaction.balance_string).to eq '100.00'
    end

    it 'calculates and sets balances for two transactions' do
      
    end
  end
end
