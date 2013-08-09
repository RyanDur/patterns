class PubSub
  attr_reader :subscription

  def initialize
    @subscription = Hash.new {|hash, key| hash[key] = {}}
    @id = 0
  end

  def subscribe eventName, &block
    id = generate_id

    @subscription[eventName][id] = block
    [eventName, id]
  end

  def publish eventName
    @subscription.fetch(eventName).each_value(&:call)
  end

  def unsubscribe id
    @subscription.fetch(id[0]).delete(id[1])
  end

  private
  def generate_id
    @id+=1
  end
end
