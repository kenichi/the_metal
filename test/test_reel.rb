require 'helper'


class TestReel < TheMetal::WebServerTest
  def self.webserver; :reel; end

  include TheMetal::StatusTests

  def setup
    require 'the_metal/reel'
    Celluloid.logger.level = ::Logger::ERROR
    super
  end

  def shutdown
    @server.stop
  end
end
