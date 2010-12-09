require 'test/unit'

class CreateTest < Test::Unit::TestCase
  CREATE_ROOT =  File.join(File.dirname(__FILE__), '..', '..')
  def test_create

    assert_template('unit_test', 'some_unit_test')
    assert_template('controller_test', 'some_controller_test')
    assert_template('ruby_class', 'some_ruby')
  end

  private
  def assert_template(test_type, template_name)
    create = File.join(CREATE_ROOT, 'bin', 'create.rb')
    template_file = File.join(CREATE_ROOT, 'test', 'fixtures', "#{template_name}.rb")
    template_class_name = template_name.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
    assert_equal IO.readlines(template_file).join, `#{create} #{test_type} name=#{template_class_name}`
  end
end
