require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }

  it 'is expected to initialise with balance 0 ' do
    expect(oystercard.balance).to eq 0
  end

  describe '#top_up' do

    it 'is expected to return the argument passed plus current balance' do
      expect(oystercard.top_up(5)).to eq 5
    end

    it 'is expected to add the argument passed to the balance variable' do
      oystercard.top_up(5)
      expect(oystercard.balance).to eq 5
    end

    it 'is expected to raise error if topup will raise balance over cap' do
      oystercard.top_up(Oystercard::CARD_CAP)
      cap_exceeded = "Cap exceeded £#{Oystercard::CARD_CAP}"
      expect { oystercard.top_up(1) }.to raise_error cap_exceeded
    end

  end

  describe '#deduct' do

    it 'is expected to return the current balance minus argument passed' do
      oystercard.top_up(10)
      expect(oystercard.deduct(5)).to eq 5
    end

    it 'is expected to reduce current balance by argument passed' do
      oystercard.top_up(25)
      expect{ oystercard.deduct(8) }.to change{ subject.balance }.by -8
    end

  end

end
