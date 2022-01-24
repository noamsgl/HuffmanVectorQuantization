
%% Question 2.1
% Noam Siegel
% January 24, 2022

%% Clear environment
close all
clear
clc

%% Initialize parameters
Q = 2^7;  % num_levels, [2^2, ..., 2^10]
N = 2;  % num_samples in each group, [1, 2, 3]

%% Load data
load('data.mat');


%% 2.2 Train Vector Quantization Codebook
% Initialize block size
N = 2;
% crop and flatten data
flat_data = crop_and_flatten(data, N);
% get VQ codebook
codebook = trainVQ(flat_data, Q, N);
% plot VQ voronoi diagram
blocked_data = reshape(flat_data.', N, []).';
scatter(blocked_data(:,1), blocked_data(:,2), 1, [0.5, 0.5, 0.5])
hold on
scatter(codebook(:,1), codebook(:,2), 'r')
h = voronoi(double(codebook(:,1)), double(codebook(:,2)));
for i=1:length(h)
    h(i).LineWidth = 1.2;
end
title("2.2 Voronoi Regions for Vector Quantization")
hold off

%% Question 2.4
% Initialize block size
N = 2;
% crop and flatten data
flat_data = crop_and_flatten(data, N);
% Build quantization levels (i.e. [4, 8, 16, 32, ..., 512, 1024])
Qs = arrayfun(@pow2, 2:10);
% Calculate distortion measure for each quantization level
for i=1:length(Qs)
    % Get quantization level
    Q = Qs(i);
    % Generate codebook
    codebook = trainVQ(flat_data, Q, N);
    % Encode signal
    encoded = VQencode(blocked_data, codebook);
    % Reconstruct signal
    blocked_reconstructed = VQdecode(encoded, codebook);
    % Flatten encoded signal
    flat_reconstructed = reshape(blocked_reconstructed.', [], 1).';
    % Measure distortion measure
    distortion = PRD(flat_data, flat_reconstructed);
    % Insert distortion measure into Ds
    Ds(i) = distortion;
    fprintf("Q is %d, distortion is %f\n", Q, distortion)
end
% Calculate Bit Rates (bits per sample)
Bs = arrayfun(@(Q) log2(Q)/N, Qs);
% Plot Distortion Measure as function of Bit Rate (bits per sample)
plot(Bs, Ds)
ylabel("PRD")
xlabel("bits per sample")
title("Distortion Measure as function of Bit Rate")

%% End message
fprintf("success\n")
