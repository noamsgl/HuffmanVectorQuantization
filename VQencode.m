% VQencode.m
% Noam Siegel
% January 24, 2022
function encoded = VQencode(original, codebook)
%VQENCODE encode the original signal with the VQ codebook (each N columns)
%   return encoded signal (N columns)

[D, I] = pdist2(codebook, original, 'euclidean', 'Smallest', 1);

encoded = I;
end

