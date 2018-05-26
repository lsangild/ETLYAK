classdef TransferFunctions < matlab.mixin.SetGet
  properties (Access = protected)
    pRef = 20e-6;
  end
  
  methods (Abstract, Access = public)
    L = transform(obj, f)
  end
  
  methods
      function handle = plotResponse(obj, f, H)
      if nargin == 1
        f = logspace(2, 4, 100);
      elseif nargin >= 4
        error('Supply a list of frequencies to plot or none to plot from 100 Hz to 10000 Hz');
      end
      p = transform(obj, f);
      L = 20 * log10(abs(p) ./ obj.pRef);
      
      if nargin == 3
        figure(H);
      else
        figure;
      end
      semilogx(f, L);
      hold on
      grid on
      xlabel('Frequency / Hz');
      ylabel('Amplitude / dB_{SPL}');
      
      handle = gcf;
    end
  end
end
