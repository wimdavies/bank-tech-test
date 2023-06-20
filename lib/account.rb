# frozen_string_literal: true

class Account
  def initialize
    @transactions = []
  end

  attr_reader :transactions

  def add(transaction)
    @transactions.push(transaction).sort_by!(&:date).reverse!
  end

  def calculate_balances
    @transactions[0].balance = @transactions[0].amount
  end
end
