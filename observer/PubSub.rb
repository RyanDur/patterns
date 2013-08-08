class PubSub
  attr_reader :subscription

  def initialize
    @subscription = Hash.new
  end

  def subscribe eventName, &block
    if @subscription.has_key? eventName
      @subscription.fetch(eventName).push block
    else
      @subscription[eventName] = [block]
    end
  end

  def publish eventName
    @subscription.fetch(eventName).each do |event|
      event.call
    end
  end
end
