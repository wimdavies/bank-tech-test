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
    
    # @io.puts '14/01/2023 || || 500.00 || 2500.00'
    # @io.puts '13/01/2023 || 2000.00 || || 3000.00'
    # @io.puts '10/01/2023 || 1000.00 || || 1000.00'
  end
end
