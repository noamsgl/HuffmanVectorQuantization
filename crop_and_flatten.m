% crop_and_flatten.m
% Noam Siegel
% January 24, 2022
function flat_data = crop_and_flatten(data, N)
% crop_to_N crops the data to a multiple of N time samples, 
% and flattens

data = data(:,1:end - mod(width(data), N));
n_channels = height(data);
n_samples = width(data);
flat_data = reshape(data.', n_channels * n_samples, []).';

end