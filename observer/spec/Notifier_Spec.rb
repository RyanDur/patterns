require "spec_helper"

describe 'Notifier' do

  describe 'update' do
    it 'should update its subscribers' do
      notifier = Notifier.new
      notifier.update
    end
  end
end
