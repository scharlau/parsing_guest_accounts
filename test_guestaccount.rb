require 'test/unit'
require 'prawn'
require './uoa-environment'
require './guestaccount'

class TestGuestAccount < Test::Unit::TestCase

  def test_guestaccount
    parse = GuestAccount.new
    @base_accounts = []
    # use one for emails other for pairs
   # @base_accounts =  parse.parse_accounts(ENV['email_messages'])
    @base_accounts =  parse.parse_pairs(ENV['email_messages'])
    parse.generate_cvs
    parse.generate_pdf(@base_accounts)
  end



end
