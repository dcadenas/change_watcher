require 'rubygems'
require 'expectations'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'change_watcher'

class TestStore
  def initialize
    @array = []
  end

  def latest_value
    @array.last
  end

  def empty?
    @array.empty?
  end

  def save(value)
    @array << value
  end
end

class Test::Unit::TestCase
end
