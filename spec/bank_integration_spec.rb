# frozen_string_literal: true

require 'transaction'
require 'account'
require 'statement'

RSpec.describe 'Integration' do
  let(:account) { Account.new }
  let(:io) { double(:io) }

  it 'prints the statement that satisfies the acceptance criteria' do
    expect(io).to receive(:puts).with('date || credit || debit || balance').ordered
    expect(io).to receive(:puts).with('14/01/2023 || || 500.00 || 2500.00').ordered
    expect(io).to receive(:puts).with('13/01/2023 || 2000.00 || || 3000.00').ordered
    expect(io).to receive(:puts).with('10/01/2023 || 1000.00 || || 1000.00').ordered

    transaction1 = Transaction.new(1000, '10-01-2023')
    transaction2 = Transaction.new(2000, '13-01-2023')
    transaction3 = Transaction.new(-500, '14-01-2023')

    account = Account.new
    account.add(transaction1)
    account.add(transaction2)
    account.add(transaction3)

    statement = Statement.new(account, io)
    statement.print
  end

  xit 'prints a statement of only credits' do
    expect(io).to receive(:puts).with('date || credit || debit || balance').ordered
    expect(io).to receive(:puts).with('14/01/2023 || 100.00 || || 300.00').ordered
    expect(io).to receive(:puts).with('13/01/2023 || 100.00 || || 200.00').ordered
    expect(io).to receive(:puts).with('10/01/2023 || 100.00 || || 100.00').ordered

    transaction1 = Transaction.new(100, '20-06-2023')
    transaction2 = Transaction.new(100, '21-06-2023')
    transaction3 = Transaction.new(100, '22-06-2023')

    account = Account.new
    account.add(transaction1)
    account.add(transaction2)
    account.add(transaction3)

    statement = Statement.new(account, io)
    statement.print
  end

  xit 'prints a statement of only debits, with negative balances' do
    expect(io).to receive(:puts).with('date || credit || debit || balance').ordered
    expect(io).to receive(:puts).with('12/01/2023 || || 100.00 || -300.00').ordered
    expect(io).to receive(:puts).with('11/01/2023 || || 100.00 || -200.00').ordered
    expect(io).to receive(:puts).with('10/01/2023 || || 100.00 || -100.00').ordered

    transaction1 = Transaction.new(-100, '10-01-2023')
    transaction2 = Transaction.new(-100, '11-01-2023')
    transaction3 = Transaction.new(-100, '12-01-2023')

    account = Account.new
    account.add(transaction1)
    account.add(transaction2)
    account.add(transaction3)

    statement = Statement.new(account, io)
    statement.print
  end

  context 'transactions are added out of date order' do
    xit 'prints transactions sorted by date order' do
      expect(io).to receive(:puts).with('date || credit || debit || balance').ordered
      expect(io).to receive(:puts).with('14/01/2023 || || 500.00 || 2000.00').ordered
      expect(io).to receive(:puts).with('13/01/2023 || 2000.00 || || 2500.00').ordered
      expect(io).to receive(:puts).with('10/01/2023 || 500.00 || || 500.00').ordered

      transaction1 = Transaction.new(2000, '13-01-2023')
      transaction2 = Transaction.new(-500, '14-01-2023')
      transaction3 = Transaction.new(500, '10-01-2023')

      account = Account.new
      account.add(transaction1)
      account.add(transaction2)
      account.add(transaction3)

      statement = Statement.new(account, io)
      statement.print
    end
  end
end
