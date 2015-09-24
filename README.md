# MoneyConverter.gem

A tiny converter of currencies.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'money_converter.gem'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install money_converter.gem

## Usage

### Configuration

```ruby
  conversion_rates = {
    'EUR' => {
      'DKK' => 7.46076,
      'USD' => 1.11885
    },
    'DKK' => {
      'EUR' => 0.134033,
      'USD' => 0.149708
    },
    'USD' => {
      'DKK' => 6.61330,
      'EUR' => 0.886485
    }
  }

  MoneyConverter.configure do |config|
    config.conversion_rates conversion_rates
  end
```

### Action

```ruby
  twenty_dollars = MoneyConverter::Money.new(20, 'USD')
  fifty_eur = MoneyConverter::Money.new(50, 'EUR')

  fifty_eur.amount    # => 50
  fifty_eur.currency  # => "EUR"
  fifty_eur.inspect   # => "50.00 EUR"

  fifty_eur == twenty_dollars # false
  fifty_eur < twenty_dollars  # false
  fifty_eur > twenty_dollars  # true

  fifty_eur + twenty_dollars  # => 67.73 EUR
  fifty_eur - twenty_dollars  # => 32.27 EUR
  fifty_eur / 2               # => 25.00 EUR
  twenty_dollars * 3          # => 60.00 USD

  fifty_eur.convert_to('USD') # => 55.94 USD
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/money_converter.gem/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
