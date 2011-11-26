require 'test_helper'

class MemberMailerTest < ActionMailer::TestCase
  test "added" do
    mail = MemberMailer.added
    assert_equal "Added", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "removed" do
    mail = MemberMailer.removed
    assert_equal "Removed", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
