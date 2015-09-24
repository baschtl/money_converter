describe MoneyConverter::Money do

  describe "#inspect" do

    let(:options) { [50, 'EUR'] }

    subject { described_class.new(*options) }

    its(:inspect) { is_expected.to eq "50.00 EUR" }

  end

end
