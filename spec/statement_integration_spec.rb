# frozen_string_literal: true

require 'transaction'
require 'account'
require 'statement'

RSpec.describe 'Statement integration' do
  let(:account) { Account.new }
  let(:io) { double(:io) }

  it 'prints the statement that satisfies the acceptance criteria' do
    expect(io).to receive(:puts).with('date || credit || debit || balance').ordered
    expect(io).to receive(:puts).with('14/01/2023 || || 500.00 || 2500.00').ordered
    expect(io).to receive(:puts).with('13/01/2023 || 2000.00 || || 3000.00').ordered
    expect(io).to receive(:puts).with('10/01/2023 || 1000.00 || || 1000.00').ordered

    time1 = Time.new(2023, 1, 10)
    allow(Time).to receive(:now).and_return(time1)
    transaction1 = Transaction.new(1000)

    time2 = Time.new(2023, 1, 13)
    allow(Time).to receive(:now).and_return(time2)
    transaction2 = Transaction.new(2000)

    time3 = Time.new(2023, 1, 14)
    allow(Time).to receive(:now).and_return(time3)
    transaction3 = Transaction.new(-500)

    account.add(transaction1)
    account.add(transaction2)
    account.add(transaction3)

    statement = Statement.new(account, io)
    statement.print_statement
  end

  it 'prints a statement of only credits' do
    expect(io).to receive(:puts).with('date || credit || debit || balance').ordered
    expect(io).to receive(:puts).with('22/06/2023 || 100.00 || || 300.00').ordered
    expect(io).to receive(:puts).with('21/06/2023 || 100.00 || || 200.00').ordered
    expect(io).to receive(:puts).with('20/06/2023 || 100.00 || || 100.00').ordered

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

    statement = Statement.new(account, io)
    statement.print_statement
  end

  it 'prints a statement of only debits, with negative balances' do
    expect(io).to receive(:puts).with('date || credit || debit || balance').ordered
    expect(io).to receive(:puts).with('12/01/2023 || || 100.00 || -300.00').ordered
    expect(io).to receive(:puts).with('11/01/2023 || || 100.00 || -200.00').ordered
    expect(io).to receive(:puts).with('10/01/2023 || || 100.00 || -100.00').ordered

    time1 = Time.new(2023, 1, 10)
    allow(Time).to receive(:now).and_return(time1)
    transaction1 = Transaction.new(-100)

    time2 = Time.new(2023, 1, 11)
    allow(Time).to receive(:now).and_return(time2)
    transaction2 = Transaction.new(-100)

    time3 = Time.new(2023, 1, 12)
    allow(Time).to receive(:now).and_return(time3)
    transaction3 = Transaction.new(-100)

    account.add(transaction1)
    account.add(transaction2)
    account.add(transaction3)

    statement = Statement.new(account, io)
    statement.print_statement
  end

  context 'when transactions are added out of date order' do
    it 'prints transactions sorted by date order' do
      expect(io).to receive(:puts).with('date || credit || debit || balance').ordered
      expect(io).to receive(:puts).with('14/01/2023 || || 500.00 || 2000.00').ordered
      expect(io).to receive(:puts).with('13/01/2023 || 2000.00 || || 2500.00').ordered
      expect(io).to receive(:puts).with('10/01/2023 || 500.00 || || 500.00').ordered

      time1 = Time.new(2023, 1, 13)
      allow(Time).to receive(:now).and_return(time1)
      transaction1 = Transaction.new(2000)

      time2 = Time.new(2023, 1, 14)
      allow(Time).to receive(:now).and_return(time2)
      transaction2 = Transaction.new(-500)

      time3 = Time.new(2023, 1, 10)
      allow(Time).to receive(:now).and_return(time3)
      transaction3 = Transaction.new(500)

      account.add(transaction1)
      account.add(transaction2)
      account.add(transaction3)

      statement = Statement.new(account, io)
      statement.print_statement
    end
  end
end
