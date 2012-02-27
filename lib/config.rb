require 'pathname'
require 'yaml'

PRIORITY = [
  'VERY_LOW',
  'MODERATE',
  'NORMAL',
  'HIGH',
  'EMERGENCY'
]

config_file = Pathname.new("#{File.dirname(__FILE__)}/../config/config.yml")
$CONFIG = YAML.load_file(config_file)
