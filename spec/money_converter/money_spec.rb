describe MoneyConverter::Money do

  let(:conversion_rates) do
    {
      'EUR' => {
        'DKK' => 7.46076,
        'USD' => 1.11885,
        'BITCOIN' => 0.0047
      },
      'DKK' => {
        'EUR' => 0.134033,
        'USD' => 0.149708,
        'BITCOIN' => 0.000649578
      }
    }
  end

  before :each do
    MoneyConverter.configure do |config|
      config.conversion_rates conversion_rates
    end
  end

  describe "#inspect" do

    let(:options) { [50, 'EUR'] }

    subject { described_class.new(*options) }

    its(:inspect) { is_expected.to eq "50.00 EUR" }

  end

  describe "#/" do

    let(:money) { described_class.new(50, 'EUR') }
    let(:divisor) { 5 }

    subject { money / divisor }

    its(:amount) { is_expected.to eq 10 }
    its(:currency) { is_expected.to eq 'EUR' }

  end

  describe "#convert_to" do

    let(:initial_amount) { 50 }
    let(:initial_currency) { 'EUR' }
    let(:money) { described_class.new(initial_amount, initial_currency) }

    subject { money.convert_to(currency_to_convert_to) }

    context "with same currency to convert to" do

      let(:currency_to_convert_to) { 'EUR' }

      its(:amount) { is_expected.to eq initial_amount }
      its(:currency) { is_expected.to eq initial_currency }

    end

    context "with a different currency to convert to" do

      let(:currency_to_convert_to) { 'USD' }

      let(:expected_amount) do
        rate = conversion_rates[initial_currency][currency_to_convert_to]
        (initial_amount * rate).round(2)
      end

      its(:amount) { is_expected.to eq expected_amount }
      its(:currency) { is_expected.to eq currency_to_convert_to }

    end

    context "with an unknown currency to convert to" do

      let(:currency_to_convert_to) { 'GBP' }

      it "raises a MoneyConverter::CurrencyConversionError" do
        expect {
          subject
        }.to raise_error MoneyConverter::CurrencyConversionError
      end

    end

  end

end
