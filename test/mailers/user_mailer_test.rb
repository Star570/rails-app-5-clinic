require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "notify_pin" do
    mail = UserMailer.notify_pin
    assert_equal "Notify pin", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
