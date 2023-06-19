require 'transaction'
require 'account'
require 'statement'

RSpec.describe 'Integration' do
  it 'prints the statement that satisfies the acceptance criteria' do
    io = double :io
    expect(io).to receive(:puts).with('date || credit || debit || balance').ordered
    expect(io).to receive(:puts).with('14/01/2023 || || 500.00 || 2500.00').ordered
    expect(io).to receive(:puts).with('13/01/2023 || 2000.00 || || 3000.00').ordered
    expect(io).to receive(:puts).with('10/01/2023 || 1000.00 || || 1000.00').ordered

    transaction_1 = Transaction.new(1000, '10-01-2023')
    transaction_2 = Transaction.new(2000, '13-01-2023')
    transaction_3 = Transaction.new(-500, '14-01-2023')

    account = Account.new
    account.add(transaction_1)
    account.add(transaction_2)
    account.add(transaction_3)

    statement = Statement.new(account, io)
    statement.print
  end
end
