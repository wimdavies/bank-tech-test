# frozen_string_literal: true

class Account
  def initialize
    @transactions = []
  end

  attr_reader :transactions

  def add(transaction)
    @transactions << transaction
  end
end
