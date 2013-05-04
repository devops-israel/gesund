class Gesund::Output::Text
  def initialize(checks)
    checks.each do |check|
      print check.first == 200 ? "- " : "x "
      puts check.last
    end
  end
end
