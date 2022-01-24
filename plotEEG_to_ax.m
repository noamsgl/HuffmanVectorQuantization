% plotEEG_to_ax.m
% Noam Siegel
% January 24, 2022
function handle = plotEEG_to_ax(ax, data, sfreq, title_str)
% Plot zscored EEG data to the given axis
% Initialize params
n_samples = width(data);
n_channels = height(data);
dt = 1/sfreq;
T = (n_samples-1)*dt;
times = 0:dt:T;

% Normalize data
data = zscore(data, 0, 2);

% Plot data
hold on
for i=1:n_channels
   handle = plot(ax, times, data(i,:) + 4*i);
end
xlabel("time (seconds)")
title(title_str)
hold off
end