% VQencode.m
% Noam Siegel
% January 24, 2022
function encoded = VQencode(data, codebook, N)
%VQENCODE encode the original signal with the VQ codebook (each N columns)
%   return encoded signal (N columns)

% Reshape data to column 
data = reshape(data.', N, []).';

[D, I] = pdist2(codebook, data, 'euclidean', 'Smallest', 1);

encoded = I;
end

