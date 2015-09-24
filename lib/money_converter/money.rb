module MoneyConverter

  class Money

    attr_accessor :amount, :currency

    def initialize(amount, currency)
      @amount = amount
      @currency = currency
    end

    def inspect
      "#{'%.2f' % amount} #{currency}"
    end

    def convert_to(currency)
      if currency == self.currency
        self.dup
      else
        Money.new(converted_amount_for(currency), currency)
      end
    end

    private

    def converted_amount_for(currency)
      rate = MoneyConverter.config.conversion_rates[self.currency][currency]
      (self.amount * rate).round(2)
    end

  end

end
