describe MoneyConverter do

  describe ".config" do

    subject { MoneyConverter.config }

    before :each do
      MoneyConverter.configure do |config|
        config.conversion_rates conversion_rates
      end
    end

    context "configured with currencies" do
      let(:conversion_rates) do
        {
          EUR: {
            DKK: 7.46076,
            USD: 1.11,
            BITCOIN: 0.0047
          },
          DKK: {
            EUR: 0.134033,
            USD: 0.149708,
            BITCOIN: 0.000649578
          }
        }
      end

      its(:conversion_rates) { is_expected.to eq(conversion_rates) }
    end

  end

end
