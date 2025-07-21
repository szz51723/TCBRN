classdef FlipLayer < nnet.layer.Layer
    methods
        function layer = FlipLayer(name)
            layer.Name = name;
        end
        function Y = predict(~, X)
            Y = flip(X,2);
        end
    end
end
