module Efatura
  class Configuration
    attr_accessor :nif, :password

    def initialize
      @nif = nil
      @password = nil
    end
  end
end
