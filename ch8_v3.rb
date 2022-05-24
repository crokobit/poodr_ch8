# Combining Objects with Composition, without inheritance

class Bicycle
  attr_accessor :parts

  def spares
    parts.spares
  end
end

class Parts
  extend Forwardable
  def_delegators :@parts, :size, :each
  include Enumerable

  attr_accessor :parts

  def initialize(args)
    @parts = args.fetch(:parts)
  end

  def spares
    parts.select { |part| part.needs_spare }
  end

  private

  def default_chain
    '10-speed'
  end

  def default_tire_size
    raise NotImplementedError
  end
end

# what below class *Parts class do
# 1. local parts defined
# 2. whether need spare of specific part defined
#
# We want something that response to above behaviors, Here we use a class.

class Part
  attr_accessor :name, :needs_spear, :description

  def initialize(args)
    @name         = args[:name]
    @description  = args[:description]
    @needs_spare  = args.fetch(:needs_spare, true)
  end
end

chain =
  Part.new(name: 'chain', description: '10-speed')

road_tire =
  Part.new(name: 'tire_size',  description: '23')

tape =
  Part.new(name: 'tape_color', description: 'red')

mountain_tire =
  Part.new(name: 'tire_size',  description: '2.1')

rear_shock =
  Part.new(name: 'rear_shock', description: 'Fox')

front_shock =
  Part.new(
    name: 'front_shock',
    description: 'Manitou',
    needs_spare: false)

mountain_bike = Bicycle.new(parts: Parts.new([chain, mountain_tire, front_shock, rear_shock]))

tape_mountain_bike = Bicycle.new(parts: Parts.new([chain, mountain_tire, front_shock, rear_shock, tape]))

road_bike = Bicycle.new(parts: Parts.new([chain, road_tire, tape]))

# We want something that response to above behaviors, Actually we don't need Part class.
# Becuase it has no additional behavior. it is just a colleciton of values.
# We can use OpenStruct in ruby

chain = OpenStruct.new(name: 'chain', description: '10-speed')
chain.name # -> chain
chain.description # -> 10-speed
