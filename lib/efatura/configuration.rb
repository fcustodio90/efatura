module Efatura
  class Configuration
    attr_accessor :nif, :password
    # SET THE CONFIGURATION INITIALIZER WITH NIL VALUES SINCE THIS INFORMATION
    # WILL COME FROM THE GEM USER
    def initialize
      @nif = nil
      @password = nil
    end
  end
end
