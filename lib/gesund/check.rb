module Gesund
  module Check
    attr_accessor :success, :message
    def call
      status  = self.success ? 200 : 500
      headers = { "Content-Type" => "text/plain" }
      message = self.message || "#{self.class} is broken!"
      status  = 500 unless self.message
      return [status, headers, [message]]
    end
  end
end
