# frozen_string_literal: true

require 'date'

class Transaction
  def initialize(amount, date)
    @amount = amount.to_f
    @date = Date.parse(date)
    @current_balance = 0.0
  end

  attr_reader :amount, :date, :current_balance

  def amount_string
    @amount.positive? ? " || #{format('%.2f', @amount)} || || " : " || || #{format('%.2f', -@amount)} || "
  end
end
