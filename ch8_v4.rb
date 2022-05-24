# what below class *Parts class do
# 1. local parts defined
# 2. whether need spare of specific part defined
#
# We want something that response to above behaviors, Here we use OpenStruct here

# Factory: an object that creates other objects.


module PartsFactory
  def self.build(config, parts_class = Parts)
    parts_class.new(
      config.collect {|part_config|
        create_part(part_config)})
  end

  def self.create_part(part_config)
    OpenStruct.new(
      name:        part_config[0],
      description: part_config[1],
      needs_spare: part_config.fetch(2, true))
  end
end

road_config =
  [['chain',        '10-speed'],
   ['tire_size',    '23'],
   ['tape_color',   'red']]

mountain_config =
  [['chain',        '10-speed'],
   ['tire_size',    '2.1'],
   ['front_shock',  'Manitou', false],
   ['rear_shock',   'Fox']]

mountain_parts = PartsFactory.build(mountain_config)
# -> <Parts:0x000001009ad8b8 @parts=
#      [#<OpenStruct name="chain",
#                    description="10-speed",
#                    needs_spare=true>,
#       #<OpenStruct name="tire_size",
#                    description="2.1",
#                    etc ...
road_bike = Bicycle.new(parts: mountain_parts)
