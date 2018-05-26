classdef DriveUnit < TransferFunctions
  properties (Access = private)
    %% Defaults
    % Density of air (kg/m^3)
    rho     = 1.1839;
    % Distance to microphone (m)
    rF      = 1;
  end
  properties (Access = private)
    %% Data sheet values
    fs
    Qts
    Bl
    Rms
    Mms
    Cms
    Sd
    Re
    Rnom
    %% Derived values
    UG
  end
  
  methods (Access = public)
      function p = transform(obj, f)
          % TRANSFORM Create the transfer function for a drive unit
          % mounted in an infinite baffle.
          %
          % L = TRANSFORM(f) Returns the sound pressure.
          setDerivedParameters(obj);
          % p = rho*Sd*Bl*UG/2*pi*Mms*Re
          
          A = (obj.rho * obj.Sd * obj.Bl * obj.UG) / (2 * pi * obj.Mms * obj.Re);
          wS = 2 * pi * obj.fs;
          s = 1i .* 2 .* pi .* f;
          AL = abs(s.^2 ./ (s.^2 + (1/obj.Qts) .* wS .* s + wS^2));
          p = (A/obj.rF) .* AL;
      end
  
      function setParameters(obj, Qts, Bl, Rms, Mms, Cms, Sd, Re, Rnom, fs)
          % SETPARAMETERS Sets the parameters for the drive unit.
          % The parameters should be found in the datasheet for the 
          % given drive unit. 
          %
          % SETPARAMETERS(Qts, Bl, Rms, Mms, Cms, Sd, Re, Rnom, fs)
          % Qts  Total Q of the drive unit [0.0 < Qts < 1.0]
          % Bl   Product of magnet field strength and length of wire in the magnetic field (Tm)
          % Rms  Mechanical resistance of the drive unit's suspension (Ns/m)
          % Mms  Mass of the diaphragm/coil (kg)
          % Cms  Compliance of the drive unit's suspension (m/N)
          % Sd   Effective surface area of driver diaphragm (cm^2) [1.0 < Sd < 1000.0]
          % Re   DC resistance of the voice coil (ohm)
          % Rnom Nominel resistance of drive unit (ohm)
          % fs   Resonance frequency of the drive unit (Hz)
          if  (Sd > 1) && (Sd < 1000)
              obj.Sd = Sd/1000;
          else
              warning('Sd is specified in cm^2')
          end
          obj.Qts = Qts;
          obj.Bl = Bl;
          obj.Rms = Rms;
          obj.Mms = Mms;
          obj.Cms = Cms;
          obj.Re = Re;
          obj.Rnom = Rnom;
          obj.fs = fs;
          setDerivedParameters(obj);
      end
      
      function setDerivedParameters(obj)
          % SETDERIVEDPARAMETERS Sets the derived parameters 
          % dependent on the given drive unit.
          %
          % UG Voltage for 1 W electric power in nominel resistance ohm
          obj.UG = sqrt(1*obj.Rnom);
      end
      
      function setConstants(obj, rho, rF)
        % SETCONSTANTS Change default values of rho, pRef and rf.
        %
        % SETCONSTANTS(rho, pRef, rf)
        % rho  Density of air (kg/m^3)
        % rf   Distance to microphone (m)
   
        % Check for correct number of input arguments
        if ~(any([1, 3] == nargin))
          error(' Call setConstants(rho, r) with 2 parameters or\n%s',...
          'with 0, setConstants(), to reset to default.');
        end
        if nargin == 1
          obj.rho = 1.1839;
          obj.rF = 1;
        else
          obj.rho = rho;
          obj.rF = rF;
        end
      end
  end
end
