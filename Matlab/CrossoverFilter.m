classdef CrossoverFilter < TransferFunctions
    properties (Access = public)
    passthrough = 0;
    
    properties (Access = private)
        f0
        Q
        type
        
        % Derived
        d
    end
    methods (Access = public)
        function passThrough()
        end
        
        function A = transform(obj, f)
            setDerivedParameters(obj);
            s = 1i * 2 * pi .* f;
            switch obj.type
                case 'low'
                    %A = 1 ./ (1 + s / (2 * pi * obj.f0)); % first order
                    A = (((2 * pi * obj.f0)^2) ./ (((2 * pi * obj.f0)^2)...
                        + 2 * obj.d * (2 * pi * obj.f0) * s + s.^2)); % second order
                    %L = 20 .* log10(abs(lp) ./ obj.pRef);
                case 'high'
                    %A = (s / (2 * pi * obj.f0)) ./ (1 + (s / (2 * pi * obj.f0))); % first order
                    A = (s.^2 ./ (((2 * pi * obj.f0)^2) + 2 * obj.d * ...
                        (2 * pi * obj.f0) * s + s.^2)); % second order
                    %L = 20 .* log10(abs(hp) ./ obj.pRef);
                otherwise
                    warning('Type must either be "high" or "low"');
            end
        end
        function setDerivedParameters(obj)
        % Sets the derived parameter dependent on the Q-value
          obj.d  = 1/(2.*obj.Q);
        end
        function printComponents()
        end
    end
    methods (Access = public)
        function setBehaviour(obj, f0, Q, type)
            obj.f0 = f0;
            obj.Q = Q;
            if (ischar(type) == 1)
                obj.type = type;
            else
                error('Type must be a char');
            end
        end
    end
end

        
    
