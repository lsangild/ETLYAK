classdef Cabinet% < TransferFunctions
  properties (Access = private)
    %% Defaults
    % Speed of sound (m/s) (default for 25 °C)
    c = 346.13;
    % Density of air (kg/m^3) (default for 25 °C)
    rho = 1.1839;
    % Distance to microphone (m)
    R = 1
    % Reference sound pressure (Pa)
    pRef = 20e-6;
    
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
  
  methods (Access = protected)
  % Returns the sound pressure  in dB SPL
    function L = transform(f)
        setDerivedParameters();
        s = 1i .* 2 .* pi .* f;
        qF = obj.FA ./ (obj.RAE + s .* obj.MAS + 1 ./ (s .* obj.CAS) + obj.RAS + 1 .* (s .* obj.CAB));
        pF = obj.rho .* s .* qF ./ (2 * pi * R);
        L = 20 .* log10(abs(pF) ./ pREF);
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
    function setDriveUnit(driveUnit)
      obj.driveUnit = driveUnit;
    end
    
    function setConstants(c, rho, R, pRef);
      % Check for correct number of input arguments
      if !any([1, 5] == nargin)
        error(' Call setConsants(c, rho, r, pRef) with 4 parameters or\n%s',...
        'with 0, setConstants(), to reset to default.');
      end
      
      if nargin == 1
        obj.c = 346.13;
        obj.rho = 1.1839;
        obj.R = 1;
        obj.pRef = 20e-6;
      else
        obj.c = c;
        obj.rho = rho;
        obj.R = R;
        obj.pRef = pRef;
      end
    end
    
    function setBassReflex(circumference, depth)
    end

  end
end