# Combining Objects with Composition, with inheritance
#
# In composition the larger object is connected to its parts via a has-a relationship (A Bicycle has parts).
# Part is a role and bicycles are happy to collaborate with any object that plays the role.
class Bicycle
  attr_accessor :parts

  def initialize(args)
    @parts = args[:parts]
  end

  def spares
    parts.spares
  end
end

class Parts
  attr_accessor :parts, :chain, :tire_size

  def initialize(args)
    @chain = args.fetch(:chain, default_chain)
    @tire_size = args.fetch(:tire_size, default_tire_size)
  end

  def spares
    { tire_size: tire_size }.merge(local_spares)
  end

  private

  def default_chain
    '10-speed'
  end

  def default_tire_size
    raise NotImplementedError
  end
end

# what below class do
# 1. local part defined
# 2. whether need spare defined


class RoadBikeParts < Parts
  attr_accessor :tape_color

  def post_initialize(tape_color:)
    @tape_color = tape_color
  end

  def local_spares
    { tape_color: tape_color }
  end

  def default_tire_size
    '10'
  end
end

class MountainBikeParts < Parts
  attr_reader :front_shock, :rear_shock

  def post_initialize(front_shock:, rear_shock:)
    @front_shock = front_shock
    @rear_shock = rear_shock
  end

  def local_spares
    { rear_shock:  rear_shock }
  end

  def default_tire_size
    '30'
  end
end

road_bike = Bicycle.new(parts: RoadBikeParts.new(tape_color: 'Fox'))

puts road_bike.spares
puts 'road_bike.spares'
# -> {:tire_size=>"23",
#     :chain=>"10-speed",
#     :tape_color=>"red"}

mountain_bike = Bicycle.new(parts: MountainBikeParts.new(front_shock: 'X', rear_shock: 'Y'))
puts 'mountain_bike'
puts mountain_bike

puts 'mountain_bike.spares'
puts mountain_bike.spares
# -> {:tire_size=>"2.1",
#     :chain=>"10-speed",
#     :rear_shock=>"Fox"}