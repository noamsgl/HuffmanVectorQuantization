% maxxcorrDistortion.m
% Noam Siegel
% January 24, 2022
function distortion = maxxcorrDistortion(original, reconstructed)
% calculate the maximum-cross-correlation distortion metric
% between original and reconstructed data
maxxcorr_original = maxxcorr(original);
maxxcorr_reconstructed = maxxcorr(reconstructed);

distortion = sqrt(sum((maxxcorr_original - maxxcorr_reconstructed) .^ 2)); 
end

