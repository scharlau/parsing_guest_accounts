require 'test/unit'
require './environment'
require './guestaccount'

class TestGuestAccount < Test::Unit::TestCase

  def test_guestaccount
    parse = GuestAccount.new
    parse.parse_accounts(ENV['email_messages'])
    parse.generate_account_pages
  end
end
