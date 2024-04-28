class RocketLauncher

  GRAVITY_MAPPING = {
    'earth' => 9.807,
    'moon' => 1.62,
    'mars' => 3.711
  }

  FUEL_CALCULATION_MULTIPLIER_MAPPING = {
    launch: 0.042,
    land: 0.033,
  }

  FUEL_CALCULATION_CONSTANT_MAPPING = {
    launch: 33,
    land: 42,
  }

  def initialize(ship_mass, route)
    @ship_mass = ship_mass
    @route = route

    check_inputs
  end

  def fuel_required
    @route.reverse.inject(0) { |sum, route_item| sum + calculate_fuel_for_route(route_item, @ship_mass + sum) }
  end

  private

  def calculate_fuel_for_route(route_item, ship_mass)
    route_type, planet = route_item

    gravity = GRAVITY_MAPPING[planet]
    multiplier = FUEL_CALCULATION_MULTIPLIER_MAPPING[route_type]
    constant = FUEL_CALCULATION_CONSTANT_MAPPING[route_type]

    result = (ship_mass * gravity * multiplier - constant).floor

    return 0 if result <= 0

    result + calculate_fuel_for_route(route_item, result)
  end

  def check_inputs
    raise 'the flight ship mass is not correct' if @ship_mass.nil? || @ship_mass < 0

    @route.each_with_index do |route_item, index|
      route_type, planet = route_item

      gravity = GRAVITY_MAPPING[planet]
      multiplier = FUEL_CALCULATION_MULTIPLIER_MAPPING[route_type]
      constant = FUEL_CALCULATION_CONSTANT_MAPPING[route_type]

      raise "a route type is not correct for #{route_item}" if multiplier.nil? && constant.nil?
      raise "no gravity defined for #{route_item}" if gravity.nil?
      raise "the route path is not correct" unless next_route_path_correct?(route_item, @route[index + 1])
    end
  end

  def next_route_path_correct?(route_item, next_route_item)
    route_type, _ = route_item
    next_route_type, _ = next_route_item

    route_type != next_route_type
  end
end
