% trainVQ.m
% Noam Siegel
% January 24, 2022
function C = trainVQ(data, Q, N)
% calculate VQ codebook (mapping from code words to 
% Q is number of quantization levels
% N is number of scalars in each block
if mod(width(data), N) ~= 0
    error("the data time dimension is not a multiple of N. crop first.")
end
% Reshape data to column 
data = reshape(data.', N, []).';

% Get k cluster centroid locations
[idx, C] = kmeans(data, Q);
end
