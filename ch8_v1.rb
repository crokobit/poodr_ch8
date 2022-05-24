# Practical Object-Oriented Design in Ruby

# inheritance
#
# bicycle has chain, tire(size defined).

# RoadBike has tape.
# MountainBike has front_shock, rear_shock
# RecumbentBike has flag
#

# hook method (post_initialize here)
# use post_initialize to avoid sub class use super to call its parent method (remove dependency)
# user can add new bicycle without knowing what parent does. If you call super in sub class method then you should need to know what it is in super class.
#
#
# template_method (def local_* here)
# to invite inheritors to supply specializations


class Bicycle
  attr_accessor :chain, :tire_size

  def initialize(args)
    @chain = args.fetch(:chain, default_chain)
    @tire_size = args.fetch(:tire_size, default_tire_size)
    post_initialize(args)
  end

  def spares
    {
      tire_size: tire_size,
      chain: chain
    }.merge(local_spares)
  end

  private

  def post_initialize(args); end

  def default_tire_size
    raise NotImplementedError
  end

  def default_chain
    '10-speed'
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color

#   def initialize(args)
#     @tape_color = args[:tape_color]
#     super
#   end

  def post_initialize(args)
    @tape_color = args[:tape_color]
  end

  def local_spares
    { tape_color: tape_color }
  end

  def default_tire_size
    '23'
  end
end

class MountainBike < Bicycle
  attr_reader :front_shock, :rear_shock

  private

  def post_initialize
    @front_shock = args[:front_shock]
    @rear_shock = args[:rear_shock]
  end

  def local_spares
    { rear_shock: rear_shock }
  end

  def default_tire_size
    '2.1'
  end
end

class RecumbentBike < Bicycle
  attr_reader :flag

  private

  def post_initialize(args)
    @flag = args[:flag]
  end

  def local_spares
    {flag: flag}
  end

  def default_chain
    '9-speed'
  end

  def default_tire_size
    '28'
  end
end

road_bike = RoadBike.new(
  tire_size: '',
  chain: '',
  tape_color: 'Red'
)
