require_relative 'checkout'

describe Checkout do
  subject { Checkout.new 'rules.csv' }

  def price(goods)
    co = Checkout.new 'rules.csv'
    goods.split(//).each { |item| co.scan(item) }
    co.total
  end

  describe "test totals" do
    it "does stuff" do
      expect(price("")).to eq 0
      expect(price("A")).to eq 50
      expect(price("AB")).to eq 80
      expect(price("CDBA")).to eq 115
      expect(price("AA")).to eq 100
      expect(price("AAA")).to eq 130
      expect(price("AAAA")).to eq 180
      expect(price("AAAAA")).to eq 230
      expect(price("AAAAAA")).to eq 260
      expect(price("AAAB")).to eq 160
      expect(price("AAABB")).to eq 175
      expect(price("AAABBD")).to eq 190
      expect(price("DABABA")).to eq 190
    end
  end

  describe "incremental" do
    it "does stuff" do
      subject.total.should eq 0
      subject.scan("A");  expect(subject.total).to eq 50
      subject.scan("B");  expect(subject.total).to eq 80
      subject.scan("A");  expect(subject.total).to eq 130
      subject.scan("A");  expect(subject.total).to eq 160
      subject.scan("B");  expect(subject.total).to eq 175
    end
  end

  describe "#total_for_sku" do

  end
end
