require "rack"

class Gesund::RackApplication

  def self.start
    Rack::Server.start app: self.new
  end

  def call(env)
    # TODO: implement checks run
    [500, {"Content-Type" => "text/plain"}, ["TODO: not implemented yet"]]
  end

end
