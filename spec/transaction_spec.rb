# frozen_string_literal: true

require 'transaction'

RSpec.describe Transaction do
  context '#initialize' do
    it 'with amount as a float, date as Time.now and current balance as a zero float' do
      expected_time = Time.new(2023, 6, 22, 15)
      allow(Time).to receive(:now).and_return(expected_time)

      transaction = Transaction.new(100)
      expect(transaction.amount).to eq 100.00
      expect(transaction.date).to eq expected_time
      expect(transaction.balance).to eq 0.0
    end

    it 'fails when passed 0 as an amount' do
      expect { Transaction.new(0) }.to raise_error 'Transaction amount cannot be zero'
    end
  end

  context '#amount_string' do
    it 'returns formatted credit string when amount is positive' do
      transaction = Transaction.new(100)
      expect(transaction.amount_string).to eq ' || 100.00 || || '
    end

    it 'returns formatted debit string when amount is negative' do
      transaction = Transaction.new(-100)
      expect(transaction.amount_string).to eq ' || || 100.00 || '
    end
  end

  context '#date_string' do
    it 'returns formatted date string' do
      expected_time = Time.new(2023, 6, 22, 15)
      allow(Time).to receive(:now).and_return(expected_time)

      transaction = Transaction.new(100)
      expect(transaction.date_string).to eq '22/06/2023'
    end
  end

  context '#balance_string' do
    it 'returns formatted balance string' do
      transaction = Transaction.new(100)
      expect(transaction.balance_string).to eq '0.00'
    end
  end
end
