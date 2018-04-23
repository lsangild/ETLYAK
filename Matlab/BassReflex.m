classdef BassReflex
  properties
    circumference
    depth
    location
  end
  methods
    function setup(circumference, depth, location)
      obj.circumference = circumference;
      obj.depth = depth;
      obj.location = location;
    end
  end
end