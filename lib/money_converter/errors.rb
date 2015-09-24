module MoneyConverter

  class CurrencyConversionError < StandardError

    def initialize(from_currency, to_currency)
      super("Conversion from '#{from_currency}' to '#{to_currency}' invalid.")
    end

  end

  class UnknownCurrencyError < StandardError

    def initialize(currency)
      super("The currency '#{currency}' was not configured.")
    end

  end

end
