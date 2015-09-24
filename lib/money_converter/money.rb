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
        rate = MoneyConverter.config.conversion_rates[self.currency][currency]
        new_amount = (self.amount * rate).round(2)
        Money.new(new_amount, currency)
      end
    end

  end

end
