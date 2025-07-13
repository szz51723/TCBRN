
classdef FlipLayer < nnet.layer.Layer
    methods
        function layer = FlipLayer(name)
            layer.Name = name;
        end
        function Y = predict(~, X)
            Y = flip(X,2);%1是按列翻转，2是按行翻转
        end
    end
end