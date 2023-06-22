# frozen_string_literal: true

require 'account'
require 'transaction'

RSpec.describe 'Account integration' do
  let(:account) { Account.new }

  context 'Account#add' do
    it 'adds a single transaction' do
      transaction = Transaction.new(100)
      account.add(transaction)
      expect(account.transactions).to eq [transaction]
    end

    it 'adds multiple transactions' do
      time1 = Time.new(2023, 6, 22, 12)
      allow(Time).to receive(:now).and_return(time1)
      transaction1 = Transaction.new(200)

      time2 = Time.new(2023, 6, 22)
      allow(Time).to receive(:now).and_return(time2)
      transaction2 = Transaction.new(100)

      account.add(transaction1)
      account.add(transaction2)
      expect(account.transactions).to eq [transaction1, transaction2]
    end

    it 'sorts the array in place as transactions are added out-of-sequence' do
      time1 = Time.new(2023, 6, 20)
      allow(Time).to receive(:now).and_return(time1)
      transaction1 = Transaction.new(200)

      time2 = Time.new(2023, 6, 21)
      allow(Time).to receive(:now).and_return(time2)
      transaction2 = Transaction.new(100)

      time3 = Time.new(2023, 6, 22)
      allow(Time).to receive(:now).and_return(time3)
      transaction3 = Transaction.new(100)

      account.add(transaction1)
      account.add(transaction2)
      account.add(transaction3)
      expect(account.transactions).to eq [transaction3, transaction2, transaction1]
    end
  end

  context 'Account#calculate_balances' do
    it 'sets the balance of the first transaction correctly' do
      transaction = Transaction.new(100)
      account.add(transaction)
      account.calculate_balances

      first_balance = account.transactions[-1].balance_string
      expect(first_balance).to eq '100.00'
    end

    it 'calculates and sets balances for multiple credit transactions' do
      time1 = Time.new(2023, 6, 20)
      allow(Time).to receive(:now).and_return(time1)
      transaction1 = Transaction.new(100)

      time2 = Time.new(2023, 6, 21)
      allow(Time).to receive(:now).and_return(time2)
      transaction2 = Transaction.new(100)

      time3 = Time.new(2023, 6, 22)
      allow(Time).to receive(:now).and_return(time3)
      transaction3 = Transaction.new(100)

      account.add(transaction1)
      account.add(transaction2)
      account.add(transaction3)
      account.calculate_balances

      first_balance = account.transactions[-1].balance_string
      second_balance = account.transactions[-2].balance_string
      third_balance = account.transactions[-3].balance_string
      expect(first_balance).to eq '100.00'
      expect(second_balance).to eq '200.00'
      expect(third_balance).to eq '300.00'
    end

    it 'calculates and sets balances for multiple credit and debit transactions' do
      time1 = Time.new(2023, 6, 20)
      allow(Time).to receive(:now).and_return(time1)
      transaction1 = Transaction.new(200)

      time2 = Time.new(2023, 6, 21)
      allow(Time).to receive(:now).and_return(time2)
      transaction2 = Transaction.new(-100)

      time3 = Time.new(2023, 6, 22)
      allow(Time).to receive(:now).and_return(time3)
      transaction3 = Transaction.new(100)

      time4 = Time.new(2023, 6, 23)
      allow(Time).to receive(:now).and_return(time4)
      transaction4 = Transaction.new(-100)

      account.add(transaction1)
      account.add(transaction2)
      account.add(transaction3)
      account.add(transaction4)
      account.calculate_balances

      first_balance = account.transactions[-1].balance_string
      second_balance = account.transactions[-2].balance_string
      third_balance = account.transactions[-3].balance_string
      fourth_balance = account.transactions[-4].balance_string
      expect(first_balance).to eq '200.00'
      expect(second_balance).to eq '100.00'
      expect(third_balance).to eq '200.00'
      expect(fourth_balance).to eq '100.00'
    end
  end
end
