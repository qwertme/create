require 'test/unit'

class CreateTest < Test::Unit::TestCase
  CREATE_ROOT =  File.join(File.dirname(__FILE__), '..', '..')
  def test_create

    assert_template('unit_test', 'some_unit_test')
    assert_template('controller_test', 'some_controller_test')
    assert_template('ruby_class', 'some_ruby')
    assert_template('ruby_class', 'some_ruby_with_variables', 'variables' => 'a,b,c')
    assert_template('active_support_test', 'some_rails_test', 'name' => 'SomeRails')
    assert_template('factory', 'some_factory', 'name' => 'some_factory')
    assert_template('helper_test', 'some_helper_test', 'name' => 'SomeHelper')
  end

  private
  def assert_template(test_type, template_name, options={})
    create = File.join(CREATE_ROOT, 'bin', 'create.rb')
    template_file = File.join(CREATE_ROOT, 'test', 'fixtures', "#{template_name}.rb")
    options['name'] = template_name.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase } unless options.has_key?('name')

    assert_equal IO.readlines(template_file).join, `#{create} #{test_type} #{options.collect {|k,v| "#{k}=#{v}"}.join(' ')}`
  end
end
