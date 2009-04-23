require 'rubygems'
require 'test/unit'
require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'addthis'

class Test::Unit::TestCase

  class << self
    %w(alt href src title).each do |attribute|
      define_method(:"should_set_#{attribute}_to") do |expected|
        should "set #{attribute} to '#{expected}'" do
          assert_equal %Q{#{attribute}="#{expected}"}, @output[/#{attribute}="[^"]*"/]
        end
      end
    end

    def should_set_script_src_to(expected)
      context "" do
        setup do
          @output = @output[/<script.+src=[^>]+>/]
        end

        should_set_src_to expected
      end
    end
  end

end
