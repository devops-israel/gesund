class Gesund::Checks::Link
  include Gesund::Check
  def initialize(linkname, target=nil)
    if not File.symlink?(linkname)
      self.success = false
      self.message = "Symbolic link #{linkname} is not a symlink"
    elsif target
      self.success = (File.readlink(linkname) == target)
      self.message = "Symbolic link somelink-xxx is#{self.success ? '' : ' not'} targetting #{target}"
    else
      self.success = true
      self.message = "Symbolic link #{linkname} is a symlink"
    end
  end
end
