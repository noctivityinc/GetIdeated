require 'test_helper'

class InviteMailerTest < ActionMailer::TestCase
  test "invite" do
    mail = InviteMailer.invite
    assert_equal "Invite", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "accepted" do
    mail = InviteMailer.accepted
    assert_equal "Accepted", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
