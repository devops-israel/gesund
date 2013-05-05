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

    desc "http", "Starts a web server that answers to requests with results of checks from Gesundfile"
    def http
      gesundfile = File.expand_path(options[:gesundfile]) if options[:gesundfile]
      checks = Gesund::Dsl.evaluate(gesundfile)
      Gesund::Output::Rack.start(checks)
    end

  end
end
