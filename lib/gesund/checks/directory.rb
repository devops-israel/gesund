class Gesund::Checks::Directory
  include Gesund::Check
  def initialize(directory)
    @success = File.directory? directory
    @message = "Directory #{directory} is#{@success ? '' : " not"} a directory"
  end
end
