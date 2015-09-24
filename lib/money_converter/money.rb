module MoneyConverter

  class Money
    include Comparable

    attr_accessor :amount, :currency

    def initialize(amount, currency)
      @amount = amount
      @currency = currency
    end

    def inspect
      "#{format('%.2f', amount)} #{currency}"
    end

    def <=>(other)
      converted_other = converted_other(other)

      if amount == converted_other.amount
        0
      elsif amount < converted_other.amount
        -1
      else
        1
      end
    end

    def +(other)
      Money.new(amount + converted_other(other).amount, currency)
    end

    def -(other)
      Money.new(amount - converted_other(other).amount, currency)
    end

    def *(multiplier)
      Money.new(amount * multiplier, currency)
    end

    def /(divisor)
      Money.new(amount / divisor, currency)
    end

    def convert_to(currency)
      if currency == self.currency
        dup
      else
        Money.new(convert_amount_for(currency), currency)
      end
    end

    private

    def converted_other(other)
      if currency == other.currency
        other
      else
        other.convert_to(currency)
      end
    end

    def convert_amount_for(currency)
      if rate = MoneyConverter.config.conversion_rates[self.currency][currency]
        (amount * rate).round(2)
      else
        fail CurrencyConversionError.new(self.currency, currency)
      end
    end
  end

end
