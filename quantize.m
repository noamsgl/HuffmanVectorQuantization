% quantize.m
% Noam Siegel
% January 24, 2022
function quantized = quantize(data, Q)
% QUANTIZE return the data quantized into Q levels
% build the quantization levels
lower_edge = min(data, [], 'all');
upper_edge = max(data, [], 'all');
edges = lower_edge:((upper_edge-lower_edge)/Q):upper_edge;
% get the quantiztion indices
quantized_idxs = arrayfun(@(x) find(edges>=x, 1), data);
% get the quantized values
quantized = arrayfun(@(i) edges(i), quantized_idxs);
end