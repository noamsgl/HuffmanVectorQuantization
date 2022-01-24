% VQEncodeDecode.m
% Noam Siegel
% January 24, 2022
function reconstructed = VQEncodeDecode(data, Q, N)
%VQENCODEDECODE use Vector Quantization to encode, then decode the data.
%   Return: the reconstructed data.
if mod(width(data), N) ~= 0
    error("the data time dimension is not a multiple of N. crop first.")
end
n_channels = height(data);
% Generate codebook
codebook = trainVQ(data, Q, N);
% Encode signal
encoded = VQencode(data, codebook, N);
% Reconstruct signal
blocked_reconstructed = VQdecode(encoded, codebook);
% reshaped encoded signal
reconstructed = reshape(blocked_reconstructed.', [], n_channels).';
end

