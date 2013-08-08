require 'spec_helper'

describe 'Car' do

  before :each do
    @car = Car.new
  end

  describe 'log' do
    it 'should update the mileage' do
      @car.log 3
      @car.mileage.should eq 3

      @car.log 5
      @car.mileage.should eq 8

      @car.log 2
      @car.mileage.should eq 10
    end
  end
end
