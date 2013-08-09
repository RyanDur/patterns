class PubSub
  attr_reader :subscription

  def initialize
    @subscription = Hash.new
    @key = 0
  end

  def subscribe eventName, &block
    event = {}
    id = generate_id
    event[id] = block

    if @subscription.has_key? eventName
      @subscription.fetch(eventName).push event
    else
      @subscription[eventName] = [event]
    end
    [eventName, event]
  end

  def publish eventName
    @subscription.fetch(eventName).each do |event|
      event.each{|k,v| v.call}
    end
  end

  def unsubscribe id
    @subscription.fetch(id[0]).delete(id[1])
  end

  private
  def generate_id
    @key+=1
  end
end
