classdef Cabinet < TransferFunctions
  properties (Access = private)
    %% Defaults
    % Speed of sound (m/s) (default for 25 ??C)
    c = 346.13;
    % Density of air (kg/m^3) (default for 25 ??C)
    rho = 1.1839;
    % Distance to microphone (m)
    R = 1;
    
    %% Box parameters
    % Box volume (L)
    volume
    % Any bass reflexes
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
  
  methods (Access = public)
  % Returns the sound pressure  in dB SPL
    function pF = transform(obj, f)
        setDerivedParameters(obj);
        s = 1i .* 2 .* pi .* f;
        k0 = (obj.rho / (2 * pi * obj.R)) * ((obj.driveUnit.Bl * obj.driveUnit.Sd * obj.driveUnit.UG) / (obj.driveUnit.Re * obj.driveUnit.Mms));
        k1 = (obj.driveUnit.Bl^2 / (obj.driveUnit.Re * obj.driveUnit.Mms)) + obj.driveUnit.Rms / obj.driveUnit.Mms;
        k2 = (1 / (obj.driveUnit.Mms * obj.driveUnit.Cms)) * (1 + ((obj.driveUnit.Cms * obj.driveUnit.Sd^2) / obj.CAB));
        pF = k0 .* (s.^2 ./ (s.^2 + s .* k1 + k2));
        %qF = obj.FA ./ (obj.RAE + s .* obj.MAS + 1 ./ (s .* obj.CAS) + obj.RAS + 1 ./ (s .* obj.CAB));
        %pF = obj.rho .* s .* qF ./ (2 * pi * obj.R);
    end
    
    % Sets the derived parameters dependent on the given Drive Unit
    function setDerivedParameters(obj)
      obj.FA  = (obj.driveUnit.Bl * obj.driveUnit.UG) / (obj.driveUnit.Re * obj.driveUnit.Sd);
      obj.CAB = obj.volume / (obj.rho * obj.c.^2);
      obj.RAE = obj.driveUnit.Bl.^2 / (obj.driveUnit.Re * obj.driveUnit.Sd.^2);
      obj.MAS = obj.driveUnit.Mms / (obj.driveUnit.Sd.^2);
      obj.CAS = obj.driveUnit.Cms * (obj.driveUnit.Sd.^2);
      obj.RAS = obj.driveUnit.Rms / (obj.driveUnit.Sd.^2);
    end
  end
  
  methods (Access = public)
    % Constructor
    function obj = Cabinet(volume)
      try
        narginchk(1, 1);
        obj.volume = volume;
      catch
        warning('Cabinet created without volume. Volume set to 1.');
        obj.volume = 1;
      end
    end
    
    % Setting the drive unit
    function setDriveUnit(obj, driveUnit)
      obj.driveUnit = driveUnit;
    end
    
    function setConstants(obj, c, rho, R);
      % Check for correct number of input arguments
      if ~any([1, 4] == nargin)
        error(' Call setConsants(c, rho, r) with 3 parameters or\n%s',...
        'with 0, setConstants(), to reset to default.');
      end
      
      if nargin == 1
        obj.c = 346.13;
        obj.rho = 1.1839;
        obj.R = 1;
      else
        obj.c = c;
        obj.rho = rho;
        obj.R = R;
      end
    end
    
    function setBassReflex(circumference, depth)
    end

  end
end
