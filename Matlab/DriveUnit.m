classdef DriveUnit < TransferFunctions
  properties (Access = private)
    % Defaults
    rho     = 1.1839;
    pref    = 20e-6;
    rf      = 1;
    
    fs
    Qts
    Bl
    Rms
    Mms
    Cms
    Sd
    RE
    Rnom
  end
  
  methods (Access = protected)
      function L = transform(obj, f)
          %   (rho*Sd*Bl*UG)/(2*pi*Mms*RE)
          A = (obj.rho * obj.Sd * obj.Bl * obj.UG) / (2 * pi * obj.Mms * obj.RE);
          wS = 2 * pi * obj.fs;
          s = 1i .* 2 .* pi .* f;
          AL = abs(s.^2 ./ (s.^2 + (1/obj.Qts) .* wS .* s+ wS^2));
          L = 20*log10(abs((A / obj.rF) .* AL ./ obj.pref));
      end
  end
  
  methods (Access = public)
      function setParameters(obj, Qts, Bl, Rms, Mms, Cms, Sd, RE, Rnom, fs)
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
          obj.RE = RE;
          obj.Rnom = Rnom;
          obj.fs = fs;
      end
      
      function setDerivedParameters(obj, P)
          obj.P = P;
          obj.UG = sqrt(P*obj.Rnom);
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