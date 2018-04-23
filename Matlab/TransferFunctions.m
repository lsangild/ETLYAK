classdef TransferFunctions
  properties (Access = protected)
    a
    b
  end
  methods
    function plotResponse()
      figure
      freqz(obj.b, obj.a)
    end
  end
  methods (Abstract)
    y = transform()
  end
end