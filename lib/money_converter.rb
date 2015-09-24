require "money_converter/money"
require "money_converter/version"

module MoneyConverter

  def self.configure(&_block)
    @config = MoneyConverter::Config.new
    yield @config
  end

  def self.config
    @config
  end

  class Config

    def initialize
      @conversion_rates = {}
    end

    def conversion_rates(conversion_rates = nil)
      if conversion_rates
        @conversion_rates = conversion_rates
      else
        @conversion_rates
      end
    end

  end

end
