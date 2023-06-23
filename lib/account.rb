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
    balances = []
    running_balance = 0.0

    @transactions.reverse_each do |transaction|
      running_balance += transaction.amount
      balances << running_balance
    end

    balances.reverse
  end
end
