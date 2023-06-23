# frozen_string_literal: true

require 'transaction'
require 'account'
require 'statement'

RSpec.describe 'Statement integration' do
  let(:account) { Account.new }
  let(:io) { instance_double(IO) }

  it 'prints the statement that satisfies the acceptance criteria' do
    output = <<~STATEMENT
      date || credit || debit || balance
      14/01/2023 || || 500.00 || 2500.00
      13/01/2023 || 2000.00 || || 3000.00
      10/01/2023 || 1000.00 || || 1000.00
    STATEMENT

    expect(io).to receive(:puts).with(output)

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
    output = <<~STATEMENT
      date || credit || debit || balance
      22/06/2023 || 100.00 || || 300.00
      21/06/2023 || 100.00 || || 200.00
      20/06/2023 || 100.00 || || 100.00
    STATEMENT

    expect(io).to receive(:puts).with(output)

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
    output = <<~STATEMENT
      date || credit || debit || balance
      12/01/2023 || || 100.00 || -300.00
      11/01/2023 || || 100.00 || -200.00
      10/01/2023 || || 100.00 || -100.00
    STATEMENT

    expect(io).to receive(:puts).with(output)

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
      output = <<~STATEMENT
        date || credit || debit || balance
        14/01/2023 || || 500.00 || 2000.00
        13/01/2023 || 2000.00 || || 2500.00
        10/01/2023 || 500.00 || || 500.00
      STATEMENT

      expect(io).to receive(:puts).with(output)

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
