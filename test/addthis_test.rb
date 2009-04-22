require 'test_helper'
include Jaap3::AddThisHelper::ClassMethods

class AddthisTest < Test::Unit::TestCase

  should "be configurable"

  should "provide addthis_bookmark_button" do
    assert respond_to?(:addthis_bookmark_button)
  end

  should "alias addthis_bookmark_button as addthis_share_button" do
    assert respond_to?(:addthis_share_button)
  end

  should "provide addthis_feed_button" do
    assert respond_to?(:addthis_feed_button)
  end

  should "provide addthis_email_button" do
    assert respond_to?(:addthis_email_button)
  end
  
  [:addthis_bookmark_button, :addthis_feed_button, :addthis_email_button].each do |m|
    context "the output of #{m}" do
      setup do
        @output_lines = method(m).call("http://example.com").split("\n")
      end

      should "start with an html comment" do
        assert_equal "<!-- AddThis Button BEGIN -->", @output_lines.first
      end

      should "end with an html comment" do
        assert_equal "<!-- AddThis Button END -->", @output_lines.last
      end
    end
  end

  context "a bookmark/share tag created without params" do
    setup do
      @output = addthis_bookmark_button
    end

    should "link to http://www.addthis.com/bookmark.php" do
      assert_match '<a href="http://www.addthis.com/bookmark.php', @output
    end

    should "set url to [URL]" do
      assert_match "'[URL]'", @output
    end

    should "set title to [TITLE]" do
      assert_match "'[TITLE]'", @output
    end
  end

  context "a feed tag" do
    setup do
      @output = addthis_feed_button("http://example.com")
    end

    should "link to http://www.addthis.com/feed.php" do
      assert_match '<a href="http://www.addthis.com/feed.php', @output
    end

    should "set h1 param to example.com" do
      assert_match "&h1=http://example.com", @output
    end

    should "set url to example.com" do
      assert_match "'http://example.com')", @output
    end
  end

  context "without configuration" do
    context "a bookmark / share tag" do
    end

    context "a feed tag" do
    end
  end

  context "with configuration" do
    context "a bookmark / share tag" do
      should "output bookmark tag with tracking"
    end

    context "a feed tag" do
      should "output feed tag with tracking"
    end
  end

  should "use secure links"

end