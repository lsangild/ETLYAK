classdef CrossoverFilter < TransferFunctions
    properties
        f0
        order
        type
        pRef = 20e-6;
    end
    methods (Access = protected)
        function passThrough()
        end
        
        function L = transform(obj, f)
            s = 1i * 2 * pi .* f;
            switch obj.type
                case 'low'
                    lp = 1 ./ (1 + s / (2 * pi * obj.f0));
                    L = 20 .* log10(abs(lp) ./ obj.pRef);
                case 'high'
                    hp = (s ./ (2 * pi * obj.f0)) / (1 + (s ./ (2 * pi * obj.f0)));
                    L = 20 .* log10(abs(hp) ./ obj.pRef);
                otherwise
                    warning('Type must either be "high" or "low"');
            end
        end
        
        function printComponents()
        end
    end
    methods (Access = public)
        function setBehaviour(obj, f0, order, type)
            obj.f0 = f0;
            obj.order = order;
            if (ischar(type) == 1)
                obj.type = type;
            else
                error('Type must be a char');
            end
        end
    end
end

        
    