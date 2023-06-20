# frozen_string_literal: true

require 'transaction'

RSpec.describe Transaction do
  context '#initialize' do
    it 'with amount as a float, date as a Date object and current balance as a zero float' do
      expected_date_object = Date.parse('20-06-2023')
      transaction = Transaction.new(100, '20-06-2023')

      expect(transaction.amount).to eq 100.00
      expect(transaction.date).to eq expected_date_object
      expect(transaction.current_balance).to eq 0.0
    end
  end

  context '#amount_string' do
    it 'returns correct credit string when amount is positive' do
      transaction = Transaction.new(100, '20-06-2023')
      expect(transaction.amount_string).to eq ' || 100.00 || || '
    end

    it 'returns correct debit string when amount is negative' do
      transaction = Transaction.new(-100, '20-06-2023')
      expect(transaction.amount_string).to eq ' || || 100.00 || '
    end
  end
end
