# frozen_string_literal: true

class Statement
  def initialize(account, io)
    @account = account
    @io = io
  end

  def print
    @account.calculate_balances
    @io.puts 'date || credit || debit || balance'
    @account.transactions.each do |transaction|
      @io.puts transaction.date_string + transaction.amount_string + transaction.balance_string
    end
  end
end
