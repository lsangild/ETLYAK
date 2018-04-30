classdef DriveUnit < TransferFunctions
  properties (Access = private)
    % Defaults
    rho     = 1.1839;
    pref    = 20e-6;
    rf      = 1;
  end
  properties (Access = public)
    % Data sheet values
    fs
    Qts
    Bl
    Rms
    Mms
    Cms
    Sd
    Re
    Rnom
    
    % Derived values
    UG
  end
  
  methods (Access = protected)
      function L = transform(obj, f)
          setDerivedParameters(obj);
          %   (rho*Sd*Bl*UG)/(2*pi*Mms*Re)
          A = (obj.rho * obj.Sd * obj.Bl * obj.UG) / (2 * pi * obj.Mms * obj.Re);
          wS = 2 * pi * obj.fs;
          s = 1i .* 2 .* pi .* f;
          AL = abs(s.^2 ./ (s.^2 + (1/obj.Qts) .* wS .* s+ wS^2));
          L = 20*log10(abs((A / obj.rF) .* AL ./ obj.pref));
      end
  end
  
  methods (Access = public)
      function setParameters(obj, Qts, Bl, Rms, Mms, Cms, Sd, Re, Rnom, fs)
          if (Qts > 0) && (Qts < 1)
              obj.Qts = Qts;
          else 
              warning('Qts must be a value between 0 and 1')
          end
          
          if  (Sd > 1) && (Sd < 1000)
              obj.Sd = Sd/1000;
          else
              warning('Sd is specified in cm^2')
          end
          
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
          obj.UG = sqrt(1*obj.Rnom);
      end
      
      function setConstants(obj, rho, pref, rF)
        % Check for correct number of input arguments
        if ~(any([1, 5] == nargin))
          error(' Call setConsants(c, rho, r, pRef) with 4 parameters or\n%s',...
          'with 0, setConstants(), to reset to default.');
        end
        if nargin == 1
          obj.rho = 1.1839;
          obj.pref = 20e-6;
          obj.rF = 1;
        else
          obj.rho = rho;
          obj.pref = pref;
          obj.rF = rF;
        end
      end
  end
end