class Notifier

  def update car, miles
    puts "The car has logged #{miles} miles, totaling #{car.mileage} miles traveled."
    puts "The car needs to be taken in for a service!" if car.service < car.mileage
  end
end
