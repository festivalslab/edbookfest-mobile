module Exceptions
  class GuardianApiError < StandardError
    def message 
      "There was a problem connecting to The Guardian website."
    end
  end
end