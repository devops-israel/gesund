class Gesund::Dsl

  def self.evaluate(gesundfile)
    builder = new
    builder.eval_gesundfile(gesundfile)
    builder.all_checks
  end

  def eval_gesundfile(gesundfile)
    @checks = []
    contents = File.read(gesundfile.to_s)
    instance_eval(contents, gesundfile.to_s, 1)
  end

  def check(name, options = {})
    camel_name  = name.split('_').map(&:capitalize).join
    check_class = Object.constants.grep("Gesund::Checks::#{camel_name}").first
    @checks << check_class.new(options)
  end

  private

  def all_checks
    @checks
  end

end
