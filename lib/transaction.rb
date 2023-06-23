# frozen_string_literal: true

require 'time'

class Transaction
  def initialize(amount)
    raise 'Transaction amount cannot be zero' if amount.zero?

    @amount = amount.to_f
    @date = Time.now
  end

  attr_reader :amount, :date
  attr_accessor :balance

  def amount_string
    @amount.positive? ? " || #{format('%.2f', @amount)} || || " : " || || #{format('%.2f', -@amount)} || "
  end

  def date_string
    @date.strftime('%d/%m/%Y')
  end
end
