# frozen_string_literal: true

require 'date'

class Transaction
  def initialize(amount, date)
    @amount = amount.to_f
    @date = Date.parse(date)
    @balance = 0.0
  end

  attr_reader :amount, :date
  attr_accessor :balance

  def amount_string
    @amount.positive? ? " || #{format('%.2f', @amount)} || || " : " || || #{format('%.2f', -@amount)} || "
  end

  def date_string
    @date.strftime('%d/%m/%Y')
  end

  def balance_string
    format('%.2f', balance)
  end
end
