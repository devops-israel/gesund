require "rack"

module Gesund::Output
  class Rack
    def self.start(checks, options={})
      app = self.new
      app.checks = checks
      # http://rubydoc.info/github/rack/rack/master/Rack/Server#initialize-instance_method
      options[:Port] = options.delete 'port'
      options[:Host] = options.delete 'host'
      options[:AccessLog] = options.delete 'accesslog'
      ::Rack::Server.start({ :app => app }.merge(options))
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
