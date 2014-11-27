require 'the_metal/request'
require 'the_metal/response'
require 'reel'

module TheMetal
  class Reel

    def initialize app
      @app = app
    end

    def stop
      @serv.terminate if @serv
    end

    def listen port, address
      @serv = ::Reel::Server::HTTP.new(address, port) do |connection|
        req = connection.request
        res = if req.websocket?
                TheMetal::Response.new(101, {}, req.websocket)
              else
                TheMetal::Response.new(200, {}, connection.hijack_socket)
              end
        @app.call req, res
      end
      sleep
    end

  end

  def self.create_server app
    Reel.new app
  end

end
