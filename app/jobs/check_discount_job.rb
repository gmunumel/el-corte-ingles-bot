require_relative './lib/console_discount'

class CheckDiscountJob
  include Sidekiq::Worker

  def perform(*args)
    ConsoleDiscount.check
  end
end