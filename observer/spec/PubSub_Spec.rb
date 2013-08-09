require 'spec_helper'

describe 'PubSub' do

  let(:mock) {double(qwer: nil, asdf: nil, zxcv: nil)}

  before :each do
    @ps = PubSub.new
    @ps.subscribe 'button2Click' do
      @mock.qwer
    end

    @ps.subscribe 'button1Click' do
      @mock.asdf
    end
    allow_message_expectations_on_nil
  end

  describe 'subscribe' do
    it 'should subscribe an event but not call it' do
      expect(@mock).not_to receive :zxcv

      @ps.subscribe 'button2Click' do
        @mock.zxcv
      end
    end

    it 'should handle multiple subscriptions' do
      expect(@mock).not_to receive :qwer
      expect(@mock).not_to receive :asdf

      @ps.subscription.length.should eq 2
    end

    it 'should not overwrite if given a key it already has it but should add the block' do
      expect(@mock).not_to receive :qwer

      @ps.subscribe 'button1Click' do
        @mock.qwer
      end

      expect(@mock).not_to receive :asdf
      @ps.subscription['button1Click'].length.should eq 2
    end

    it 'should return a unique id' do
      ids = []
      ids.push @ps.subscribe 'button1Click' do
        @mock.qwer
      end

      ids.push @ps.subscribe 'button1Click' do
        @mock.qwer
      end

      ids.push @ps.subscribe 'button1Click' do
        @mock.qwer
      end

      ids.push @ps.subscribe 'button1Click' do
        @mock.qwer
      end

      ids.uniq.length.should eq ids.length
    end
  end

  describe 'publish' do
    it 'should publish the event called' do
      @mock.should_receive(:qwer)
      expect(@mock).not_to receive :asdf

      @ps.publish('button2Click')
    end

    it 'should publish all the blocks for a certain event' do
      @ps.subscribe 'button2Click' do
        @mock.qwer
      end

      @mock.should_receive(:qwer).twice
      expect(@mock).not_to receive :asdf

      @ps.publish('button2Click')

    end
  end

  describe 'unsubscribe' do
    it 'should remove the subscription of the events associated' do
      id1 = @ps.subscribe 'button2Click' do
        @mock.zxcv
      end

      @mock.should_receive :qwer
      @mock.should_receive :asdf
      expect(@mock).not_to receive :zxcv

      @ps.unsubscribe id1
      @ps.publish('button2Click')
      @ps.publish('button1Click')
    end
  end
end
