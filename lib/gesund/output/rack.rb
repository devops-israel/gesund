require "rack"

module Gesund::Output
  class Rack
    def self.start(checks)
      app = self.new
      app.checks = checks
      ::Rack::Server.start app: app
    end

    attr_accessor :checks

    def call(env)
      results = Gesund::CheckRunner.run(self.checks)
      body = []
      failflag = false
      results.each do |check|
         failflag = true if check.first.to_i != 200
         body << "#{check.first}: #{check.last.join}\n"
      end
      status = failflag ? 500 : 200
      header = { "Content-Type" => "text/plain" }
      [status, header, body]
    end
  end
end
