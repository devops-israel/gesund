module Gesund::Output
  class Text
    def initialize(checks)
      failflag = false
      checks.each do |check|
        failflag = true if check.first.to_i != 200
        puts "#{check.first}: #{check.last.join}"
      end
      puts "\nRESULT: Health check #{failflag ? "failed!" : "passed."}"
    end
  end
end
