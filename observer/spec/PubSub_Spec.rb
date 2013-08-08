require 'spec_helper'

describe 'PubSub' do

  let(:mock) {double(qwer: nil, asdf: nil)}

  before :each do
    @ps = PubSub.new
    allow_message_expectations_on_nil
  end

  describe 'subscribe' do
    it 'should subscribe an event' do
      expect(@mock).not_to receive :qwer

      @ps.subscribe 'button2Click' do
        @mock.qwer
      end
    end

    it 'should handle multiple subscriptions' do
      expect(@mock).not_to receive :qwer

      @ps.subscribe 'button2Click' do
        @mock.qwer
      end

      @ps.subscription.length.should eq 1

      expect(@mock).not_to receive :asdf

      @ps.subscribe 'button1Click' do
        @mock.asdf
      end

      @ps.subscription.length.should eq 2
    end

    it 'should not overwrite if given a key it already has but should add the block' do
      expect(@mock).not_to receive :qwer

      @ps.subscribe 'button1Click' do
        @mock.qwer
      end

      @ps.subscription.length.should eq 1

      expect(@mock).not_to receive :asdf

      @ps.subscribe 'button1Click' do
        @mock.asdf
      end

      @ps.subscription.length.should eq 1
      @ps.subscription['button1Click'].length.should eq 2
    end
  end

  describe 'publish' do
    it 'should publish the event called' do
      @ps.subscribe 'button2Click' do
        @mock.qwer
      end

      @ps.subscribe 'button1Click' do
        @mock.asdf
      end

      @mock.should_receive(:qwer)
      expect(@mock).not_to receive :asdf

      @ps.publish('button2Click')
    end

    it 'should publish all the blocks for a certain event' do
      @ps.subscribe 'button2Click' do
        @mock.qwer
      end

      @ps.subscribe 'button2Click' do
        @mock.qwer
      end

      @ps.subscribe 'button1Click' do
        @mock.asdf
      end

      @mock.should_receive(:qwer).twice
      expect(@mock).not_to receive :asdf

      @ps.publish('button2Click')

    end
  end
end
