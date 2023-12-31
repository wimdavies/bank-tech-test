# frozen_string_literal: true

require 'statement'

RSpec.describe Statement do
  let(:account) { instance_double(Account) }
  let(:io) { instance_double(IO) }
  let(:statement) { described_class.new(account, io) }

  context '#initialize' do
    it 'assigns the account and io instance variables' do
      expect(statement.instance_variable_get(:@account)).to eq account
      expect(statement.instance_variable_get(:@io)).to eq io
    end
  end

  context '#print_statement' do
    it 'prints the statement with correct formatting' do
      transaction3 = instance_double(Transaction, date_string: '14/01/2023', amount_string: ' || || 500.00 || ')
      transaction2 = instance_double(Transaction, date_string: '13/01/2023', amount_string: ' || 2000.00 || || ')
      transaction1 = instance_double(Transaction, date_string: '10/01/2023', amount_string: ' || 1000.00 || || ')

      allow(account).to receive(:calculate_balances).and_return([2500.0, 3000.0, 1000.0])
      allow(account).to receive(:transactions).and_return([transaction3, transaction2, transaction1])

      output = <<~STATEMENT
        date || credit || debit || balance
        14/01/2023 || || 500.00 || 2500.00
        13/01/2023 || 2000.00 || || 3000.00
        10/01/2023 || 1000.00 || || 1000.00
      STATEMENT

      expect(io).to receive(:puts).with(output)

      statement.print_statement
    end
  end
end
