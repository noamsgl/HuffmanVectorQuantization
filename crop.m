% crop.m
% Noam Siegel
% January 24, 2022
function cropped_data = crop(data, N)
% crops the data to the largest possible multiple of N time samples
cropped_data = data(:,1:end - mod(width(data), N));
end