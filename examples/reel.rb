class Application
  def call req, res
    if req.websocket?
      res.write "Hi, are you a Websocket?\n"
      answer = req.websocket.read
      res.write "You said '#{answer}'.\n"
      res.finish
    else
      res.write_head 200, 'Content-Type' => 'text/plain'
      res.write "Hello World\n"
      res.finish
    end
  end
end

require 'the_metal/reel'
server = TheMetal.create_server Application.new
server.listen 9292, '0.0.0.0'
