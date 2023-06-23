# frozen_string_literal: true

class Statement
  def initialize(account, io)
    @account = account
    @io = io
  end

  def print_statement
    balances = @account.calculate_balances
    @io.puts 'date || credit || debit || balance'
    @account.transactions.each_with_index do |transaction, index|
      @io.puts transaction.date_string + transaction.amount_string + format('%.2f', balances[index])
    end
  end
end
