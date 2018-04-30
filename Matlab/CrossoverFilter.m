classdef CrossoverFilter < TransferFunctions
    properties (Access = private)
        f0
        order
        type
        b
        a
    end
    methods
        function passThrough()
        end
        function setBehaviour(f0, order, type)
            obj.f0 = f0;
            obj.order = order;
            obj.type = type;
        end
        function plotResponse()
        end
        function y = transform(x)
        end
        function printComponents()
        end
    end
end

        
    