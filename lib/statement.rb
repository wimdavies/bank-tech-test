# frozen_string_literal: true

class Statement
  def initialize(account, io)
    @account = account
    @io = io
  end

  def print_statement
    @io.puts build_statement
  end

  private

  def build_statement
    balances = @account.calculate_balances
    header = "date || credit || debit || balance\n"
    statement_string = header
    @account.transactions.each_with_index do |transaction, index|
      statement_string += "#{transaction.date_string}#{transaction.amount_string}#{format('%.2f', balances[index])}\n"
    end
    statement_string
  end
end
