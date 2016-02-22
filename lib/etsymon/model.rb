module Etsymon

  ##
  # Syntactic sugar for Etsy models

  module Model
    def method_missing(method_sym, *arguments, &block)
      @data[method_sym.to_s] rescue nil
    end
  end
end
