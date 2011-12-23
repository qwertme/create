task :default => [:test]

task :test do
  ENV['CREATE_HOME'] = Dir.pwd
  ruby "test/unit/create_test.rb"
end
