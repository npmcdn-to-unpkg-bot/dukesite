require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "notify_subscription" do
    mail = UserMailer.notify_subscription
    assert_equal "Notify subscription", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "confirm_subscription" do
    mail = UserMailer.confirm_subscription
    assert_equal "Confirm subscription", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
