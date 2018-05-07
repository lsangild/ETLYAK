classdef Speaker < TransferFunctions
  properties (Access = public)
    filter
    driver
    cabinet
  end
  methods
    function p = transform(obj, f)
      % Insert test for if cabinet already has a driver, else input the
      % specified driver from obj.driver
      p = obj.filter.transform(f) .* obj.cabinet.transform(f);
    end
  end
end
