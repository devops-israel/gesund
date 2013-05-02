module Gesund::Checks
  class File
    include Gesund::Check
    def initialize(filename)
      self.success = ::File.file? filename
      self.message = "File #{filename} is#{@success ? '' : ' not'} a file"
    end
  end
end
