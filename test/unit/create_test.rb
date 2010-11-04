require 'test/unit'

class CreateTest < Test::Unit::TestCase
   def test_create
      create = File.join(File.dirname(__FILE__), '..', '..', 'bin', 'create.rb')

      assert_equal <<-CREATE, `#{create} unit_test name=Chicken`
require 'test/unit'

class ChickenTest < Test::Unit::TestCase
end
CREATE
   end
end
