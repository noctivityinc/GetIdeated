require 'test_helper'

class VersionTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Version.new.valid?
  end
end
