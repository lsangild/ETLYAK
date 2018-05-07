classdef TransferFunctions < matlab.mixin.SetGet
  properties (Access = protected)
    a
    b
    pRef = 20e-6;
  end
  
  methods (Abstract, Access = public)
    L = transform(obj, f)
  end
  
  methods
    function plotResponse(obj, f)
      if nargin == 1
        f = logspace(2, 4, 100);
      elseif nargin >= 3
        error('Supply a list of frequencies to plot or none to plot from 100 Hz to 10000 Hz');
      end
      p = transform(obj, f);
      L = 20 * log10(abs(p) ./ obj.pRef);
      
      figure
      semilogx(f, L);
      grid on
      xlabel('Frequency / Hz');
      ylabel('Amplitude / dB_{SPL}');
    end
  end
end
