# frozen_string_literal: true

require 'account'

RSpec.describe Account do
  let(:account) { described_class.new }
  
  context '#initialize' do
    it 'initializes with empty transactions array' do
      expect(account.transactions).to eq []
    end
  end
end
