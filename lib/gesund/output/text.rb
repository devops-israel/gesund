module Gesund::Output
  class Text
    def initialize(checks)
      results = Gesund::CheckRunner.run(checks)
      failflag = false
      results.each do |check|
        failflag = true if check.first.to_i != 200
        puts "#{check.first}: #{check.last.join}"
      end
      puts "\nRESULT: Health check #{failflag ? "failed!" : "passed."}"
    end
  end
end
