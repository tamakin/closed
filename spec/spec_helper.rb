require "bundler/setup"
require 'rspec'

=begin
Dir[File.join(File.dirname(__FILE__), "..", "lib", "models", "**/*.rb")].each do |f|
  require f
end
=end
Dir[File.join(File.dirname(__FILE__), "..", "*.rb")].each do |f|
  require f
end
Dir[File.join(File.dirname(__FILE__), "../lib", "*.rb")].each do |f|
  require f
end

RSpec.configure do
  #
end
