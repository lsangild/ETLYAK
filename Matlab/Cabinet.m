classdef Cabinet < TransferFunctions
  properties (Access = private)
    % Ambience (default for 25 °C)
    c = 346.13;
    rho = 1.1839;
    
    % Box parameters
    volume
    bassReflex
    
    % Drive unit
    driveUnit
    
    % Derived parameters
    FA
    CAB
    RAE
    MAS
    CAS
    RAS
    RAL
  end
  
  methods (Access = protected)
  % Returns the sound pressure  in dB SPL
    function y = transform(x)
        setDerivedParameters();
    end
    
    % Sets the derived parameters dependent on the given Drive Unit
    function setDerivedParameters()
      obj.FA  = (obj.driveUnit.BL * obj.driveUnit.UG / (obj.driveUnit.RE * obj.driveUnit.SD));
      obj.CAB = obj.volume / (obj.rho * obj.c.^2);
      obj.RAE = obj.driveUnit.BL.^2 / (obj.driveUnit.RE * obj.driveUnit.SD.^2);
      obj.MAS = obj.driveUnit.MMS / (obj.driveUnit.SD.^2);
      obj.CAS = obj.driveUnit.CMS * (obj.driveUnit.SD.^2);
      obj.RAS = obj.driveUnit.RMS / (obj.driveUnit.SD.^2);
    end
  end
  
  methods (Access = public)
    % Constructor
    function obj = Cabinet(volume)
      obj.volume = volume;
    end
    
    % Setting the drive unit
    function setDriveUnit(DU)
      obj.DU = DU;
    end
    
    function setAmbience(c, rho);
      obj.c = c;
      obj.rho = rho;
    end
    
    function setBassReflex(circumference, depth)
    end
  
    function plotResponse()
    end
  end
end