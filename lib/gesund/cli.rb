require "thor"

module Gesund
  class CLI < ::Thor
    include ::Thor::Actions
    class_option :gesundfile, :banner => '<gesundfile>', :type => :string, :default => "Gesundfile", :aliases => [:"-c"]

    default_task :check
    desc "check", "Executes the list of checks found in Gesundfile"
    def check
      gesundfile = File.expand_path(options[:gesundfile]) if options[:gesundfile]
      checks = Gesund::Dsl.evaluate(gesundfile)
      Gesund::Output::Text.new(checks)
    end

    # http://rubydoc.info/github/rack/rack/master/Rack/Server#initialize-instance_method
    option :port, :type => :numeric, :aliases => [:'-p'], :default => 9998, :desc => 'the port to bind to'
    option :host, :type => :string, :aliases => [:'-h'], :default => '0.0.0.0', :desc => 'the host address to bind to'
    option :daemonize, :type => :boolean, :aliases => [:'-d'], :default => false, :desc => 'if true, the server will daemonize itself (fork, detach, etc)'
    option :pid, :type => :string, :default => nil, :desc => 'path to write a pid file after daemonize'
    option :accesslog, :type => :string, :default => nil, :desc => 'webrick acess log options'
    option :debug, :type => :boolean, :default => false, :desc => 'turn on debug output'
    option :warn, :type => :boolean, :default => true, :desc => 'turn on warnings'
    desc "http", "Starts a web server that answers to requests with results of checks from Gesundfile"
    def http
      opts = options.dup
      gesundfile = File.expand_path(opts.delete(:gesundfile))
      raise Errno::EACCES, "Can't read file #{gesundfile}" unless File.readable?(gesundfile)
      checks = Gesund::Dsl.evaluate(gesundfile)
      Gesund::Output::Rack.start(checks, opts)
    end

  end
end
