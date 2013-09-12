require 'test/unit'

class CreateTest < Test::Unit::TestCase
  CREATE_ROOT =  File.join(File.dirname(__FILE__), '..', '..')

  def test_create
    assert_template('unit_test', 'some_unit_test.rb', :name => 'SomeUnitTest')
    assert_template('spec', 'some_spec.rb', :subject => 'SomeTestSubject')
    assert_template('controller_test', 'some_controller_test.rb', :name => 'SomeControllerTest')
    assert_template('ruby_class', 'some_ruby.rb', :name => 'SomeRuby')
    assert_template('ruby_class', 'some_ruby_with_parent.rb', :name => 'SomeRubyWithParent', :parent => 'Parent')
    assert_template('ruby_class', 'some_ruby_with_variables.rb', :name => 'SomeRubyWithVariables',:variables => 'a,b,c')
    assert_template('model_test', 'some_rails_test.rb', :name => 'SomeRails')
    assert_template('factory', 'some_factory.rb', :name => 'some_factory')
    assert_template('helper_test', 'some_helper_test.rb', :name => 'SomeHelper')
    assert_template('scala_class', 'some_scala_class.scala', :name => 'SomeScalaClass', :package => 'test.fixtures')
    assert_template('view_test', 'some_view_test.rb', :name => 'SomeView')
    assert_template('jasmine_test', 'some_jasmine_node_test.js', :name => 'SomeObject')
  end

  def test_missing_mandatory_parameter
    assert_equal "Missing mandatory parameter 'package'\n", run_create('scala_class', :name => 'SomeClass')
  end

  private
  def assert_template(template_name, fixture_name, options={})
    template_file = File.join(CREATE_ROOT, 'test', 'fixtures', "#{fixture_name}")

    assert_equal IO.readlines(template_file).join, run_create(template_name, options)
  end

  def run_create(template_name, options)
    create = File.join(CREATE_ROOT, 'bin', 'create.rb')

    `#{create} #{template_name} #{options.collect {|k,v| "#{k.to_s}=#{v}"}.join(' ')}`
  end
end
