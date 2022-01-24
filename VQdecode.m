% VQdecode.m
% Noam Siegel
% January 24, 2022
function reconstructed = VQdecode(encoded, codebook)
%VQDECODE decode the encoded signal with the VQ codebook (N columns)
%   return blocked reconstruced signal (N columns)

for i=1:length(encoded)
   idx = encoded(i);
   codeword = codebook(idx, :);
   reconstructed(i, :) = codeword;
end

end