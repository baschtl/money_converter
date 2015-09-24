module MoneyConverter

  class CurrencyConversionError < StandardError

    def initialize(from_currency, to_currency)
      super("Conversion from '#{from_currency}' to '#{to_currency}' invalid.")
    end

  end

end
