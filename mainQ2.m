
%% Question 2.1
% Noam Siegel
% January 24, 2022

%% Clear environment
close all
clear
clc

%% Load data
load('data.mat');

%% Quantize data
data = quantize(data, 2^12);

%% 2.2 Train Vector Quantization Codebook
% Initialize block size
N = 2;
% Initialize quantization level
Q = 16;  % 128
% crop and flatten data
flat_data = crop_and_flatten(data, N);
% get VQ codebook
codebook = trainVQ(flat_data, Q, N);
% reshape data into blocks of size N
blocked_data = reshape(flat_data.', N, []).';
% plot VQ voronoi diagram
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
% reshape data into blocks of size N
blocked_data = reshape(flat_data.', N, []).';
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
    fprintf("Q is %d, PRD distortion is %f\n", Q, distortion)
end
% Calculate Bit Rates (bits per sample)
Bs = arrayfun(@(Q) log2(Q)/N, Qs);
% Plot Distortion Measure as function of Bit Rate (bits per sample)
plot(Bs, Ds)
ylabel("PRD")
xlabel("bits per sample")
title("2.4 Distortion Measure as function of Bit Rate")

%% Question 2.5
% Initialize quantization levels
Q = 128;
% Initialize block sizes
Ns = [1 2 3];
% Calculate distortion measure for each block size
for i=1:length(Ns)
    % Get block size
    N = Ns(i);
    % crop and flatten data
    flat_data = crop_and_flatten(data, N);
    % reshape data into blocks of size N
    blocked_data = reshape(flat_data.', N, []).';
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
    fprintf("N is %d, PRD distortion is %f\n", N, distortion)
end

% Calculate Bit Rates (bits per sample)
Bs = arrayfun(@(N) log2(Q)/N, Ns);
% Plot Distortion Measure as function of Bit Rate (bits per sample)
plot(Bs, Ds)
ylabel("PRD")
xlabel("bits per sample")
title("2.5 Distortion Measure as function of Bit Rate")

%% End message
fprintf("success\n")
