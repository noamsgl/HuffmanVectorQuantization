% maxxcorr.m
% Noam Siegel
% January 24, 2022
function results = maxxcorr(data)
% calculate the maximum cross correlation between each 
% pair of channels in data, normalized by autocorr at time 0.
% get pairs of indices
pairs = nchoosek(1:size(data,1), 2);
% calculate cross correlations for each pair of channels
for i = 1:length(pairs)
    idx1 = pairs(i, 1);
    idx2 = pairs(i, 2);
    ch1 = data(idx1, :);
    ch2 = data(idx2, :);
    ch1_autocorr = xcorr(ch1);
    ch2_autocorr = xcorr(ch2);
    normalization_factor = sqrt(ch1_autocorr(1) * ch2_autocorr(1));
    results(i, :) = abs(xcorr(ch1, ch2)/normalization_factor);
end

results = max(results, [], 2);
end