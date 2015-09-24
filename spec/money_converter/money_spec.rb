describe MoneyConverter::Money do

  let(:conversion_rates) do
    {
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
  end

  before :each do
    MoneyConverter.configure do |config|
      config.conversion_rates conversion_rates
    end
  end

  describe "initializing Money" do

    it "does not allow instances of unknown currency" do
      expect {
        described_class.new(10, 'ABC')
      }.to raise_error MoneyConverter::UnknownCurrencyError
    end

  end

  describe "#inspect" do

    let(:options) { [50, 'EUR'] }

    subject { described_class.new(*options) }

    its(:inspect) { is_expected.to eq "50.00 EUR" }

  end

  describe "#<=>" do

    let(:money) { described_class.new(10, 'EUR') }

    subject { money <=> other_money }

    context "with an equal other" do

      context "with the same currency" do

        let(:other_money) { described_class.new(10, 'EUR') }

        it { is_expected.to eq 0 }

      end

      context "with a different currency" do

        let(:other_money) { described_class.new(74.61, 'DKK') }

        it { is_expected.to eq 0 }

      end

    end

    context "with an greater other" do

      context "with the same currency" do

        let(:other_money) { described_class.new(15, 'EUR') }

        it { is_expected.to eq -1 }

      end

      context "with a different currency" do

        let(:other_money) { described_class.new(100, 'DKK') }

        it { is_expected.to eq -1 }

      end

    end

    context "with an smaller other" do

      context "with the same currency" do

        let(:other_money) { described_class.new(5, 'EUR') }

        it { is_expected.to eq 1 }

      end

      context "with a different currency" do

        let(:other_money) { described_class.new(20, 'DKK') }

        it { is_expected.to eq 1 }

      end

    end

  end

  describe "#+" do

    subject { first_summand + second_summand }

    context "with summands of the same currency" do

      let(:currency) { 'EUR' }

      let(:first_summand) { described_class.new(15, currency) }
      let(:second_summand) { described_class.new(35, currency) }

      its(:amount) { is_expected.to eq 50 }
      its(:currency) { is_expected.to eq currency }

    end

    context "with summands of different currencies" do

      let(:euro) { 'EUR' }
      let(:krone) { 'DKK' }

      let(:first_summand) { described_class.new(15, euro) }
      let(:second_summand) { described_class.new(35, krone) }

      its(:amount) { is_expected.to be_within(0.01).of(19.69) }
      its(:currency) { is_expected.to eq euro }

    end

  end

  describe "#-" do

    subject { first_summand - second_summand }

    context "with subtrahends of the same currency" do

      let(:currency) { 'EUR' }

      let(:first_summand) { described_class.new(35, currency) }
      let(:second_summand) { described_class.new(15, currency) }

      its(:amount) { is_expected.to eq 20 }
      its(:currency) { is_expected.to eq currency }

    end

    context "with subtrahends of different currencies" do

      let(:euro) { 'EUR' }
      let(:krone) { 'DKK' }

      let(:first_summand) { described_class.new(15, euro) }
      let(:second_summand) { described_class.new(35, krone) }

      its(:amount) { is_expected.to be_within(0.01).of(10.30) }
      its(:currency) { is_expected.to eq euro }

    end

  end

  describe "#*" do

    let(:money) { described_class.new(10, 'EUR') }
    let(:multiplier) { 5 }

    subject { money * multiplier }

    its(:amount) { is_expected.to eq 50 }
    its(:currency) { is_expected.to eq 'EUR' }

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
