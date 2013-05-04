class Gesund::CheckRunner
  def self.run(checks)
    results = []
    checks.each do |check|
      begin
        results << check.call
      rescue => e
        # check failed
        results << [500, {}, ["ERROR: #{e.class}: #{e.message}"]]
      end
    end
    return results
  end
end
