class PubSub
  attr_reader :subscription

  def initialize
    @subscription = Hash.new {|hash, key| hash[key] = {}}
    @id = 0
  end

  def subscribe event_name, &block
    id = generate_id

    @subscription[event_name][id] = block
    [event_name, id]
  end

  def publish event_name
    @subscription.fetch(event_name).each_value(&:call)
  end

  def unsubscribe id
    @subscription.fetch(id[0]).delete(id[1])
  end

  private
  def generate_id
    @id+=1
  end
end
