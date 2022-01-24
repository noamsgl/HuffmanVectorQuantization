
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


%% Crop to Multiple of N and Flatten
data = data(:,1:end - mod(width(data), N));
n_channels = height(data);
n_samples = width(data);
data = reshape(data, [1, n_channels * n_samples]);

%% 2.2 Train Vector Quantization Codebook
% get VQ codebook
codebook = trainVQ(data, Q, N);
% plot VQ voronoi diagram
reshaped_data = reshape(data.', N, []).';
scatter(reshaped_data(:,1), reshaped_data(:,2), 1, [0.5, 0.5, 0.5])
hold on
scatter(codebook(:,1), codebook(:,2), 'r')
h = voronoi(double(codebook(:,1)), double(codebook(:,2)));
for i=1:length(h)
    h(i).LineWidth = 1.2;
end
title("2.2 Voronoi Regions for Vector Quantization")

%% Question 2.4
N = 2;
for i=2:10
    Q = 2^i;
    

fprintf("success\n")
