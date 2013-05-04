class Gesund::Dsl

  def self.evaluate(gesundfile)
    builder = new
    builder.eval_gesundfile(gesundfile)
  end

  def eval_gesundfile(gesundfile)
    @checks = []
    contents = File.read(gesundfile.to_s)
    instance_eval(contents, gesundfile.to_s, 1)
    return @checks
  end

  def check(name, options = {})
    camel_name = name.to_s.split('_').map(&:capitalize).join
    begin
      check_class = Gesund::Checks.const_get(camel_name)
    rescue NameError => e
      e.backtrace.join =~ /Gesundfile:(\d+)/
      print "ERROR Gesundfile:#{$1}: "
      puts "#{e.message}"
      exit 1
    end
    raise Gesund::Errors::CheckNotFound unless check_class
    @checks << check_class.new(options) if check_class
  end

end
