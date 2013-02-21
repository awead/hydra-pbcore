# :nodoc
require "hydra-pbcore"
require "equivalent-xml"

RSpec.configure do |config|
  config.color = true
end

# Returns a file from spec/fixtures
def fixture(file)
  File.new(File.join(File.dirname(__FILE__), 'fixtures', file))
end

# Returns a file from spec/fixtures/deprecated
def deprecated_fixture(file)
  File.new(File.join(File.dirname(__FILE__), 'fixtures', 'deprecated', file))
end

# Returns a file from tmp
def sample(file)
  File.new(File.join('tmp', file))
end

# Returns a Nokogiri::XML object from spec/fixtures/integration
def integration_fixture(file)
  Nokogiri::XML(File.new(File.join(File.dirname(__FILE__), 'fixtures', 'integration', file))) 
end

# Saves a sample template to tmp
def save_template input, filename
  out = File.new(File.join("tmp", filename), "w")
  out.write(input.to_s)
  out.close
end

# Tests if a file in spec/fixtures is the same as the file in tmp
def tmp_file_should_match_exemplar(file)
  f = Nokogiri::XML(fixture(file))
  s = Nokogiri::XML(sample(file))
  f.should be_equivalent_to s
end

def random_string
  (0...50).map{ ('a'..'z').to_a[rand(26)] }.join
end
