classdef TransferFunctions
  properties (Access = protected)
    a
    b
  end
  methods(Static)
    function plotResponse(f)
      if nargin == 1
        f = logspace(2, 4, 100);
      elseif nargin >= 3
        error('Supply a list of frequencies to plot or none to plot from 100 Hz to 10000 Hz');
      end
      L = transform(f);
      
      figure
      semilogx(L, f);
      grid on
      xlabel('Frequency / Hz');
      ylabel('Amplitude / dB_{SPL}');
    end
  end
  methods (Abstract, Access = protected)
    L = transform(f)
  end
end