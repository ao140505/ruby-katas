require 'csv'

class Checkout
  attr_reader :rules, :scanned_items

  def initialize(rules_file)
    @rules = parse_rules(rules_file)
    @scanned_items = Hash.new(0)
  end

  def scan(item)
    self.scanned_items[item] += 1
  end

  def total
    total = 0
    self.scanned_items.each do |item, quantity|
      total += item_total(item, quantity)
    end
    total.round
  end

  private

  # assumes higher quantities have a lower unit cost
  def item_total(item, quantity)
    price = 0
    while quantity != 0
      qty = highest_discount_quantity(item, quantity)
      price += rules[item][qty] * qty
      quantity -= qty
    end
    price
  end

  def highest_discount_quantity(item, quantity)
    quantities = rules[item].keys.sort_by{|i| -i}
    quantities.find{|i| quantity % i == 0}
  end

  def parse_rules(file)
    rules = {}
    CSV.foreach(file, headers: :first_row) do |row|
      item = row["item"]
      quantity = row["quantity"].to_i
      rules[item] ||= {}
      rules[item][quantity] = row["unit price"].to_f
    end
    rules
  end
end
