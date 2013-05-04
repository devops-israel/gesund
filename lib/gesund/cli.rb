require "thor"

module Gesund
  class CLI < ::Thor
    include ::Thor::Actions

    default_task :check
    desc "check", "Executes the list of checks found in Gesundfile"
    option :gesundfile, :type => :string, :default => "Gesundfile"
    def check
      ENV['GESUNDFILE'] = File.expand_path(options[:gesundfile]) if options[:gesundfile]
      checks = Gesund::Dsl.evaluate(ENV['GESUNDFILE'])
      Gesund::Output::Text.new Gesund::CheckRunner.run(checks)
    end

    desc "http", "Starts a web server that answers to requests with results of checks from Gesundfile"
    def http
      Gesund::RackApplication.start
    end

  end
end
