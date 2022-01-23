
% Noam Siegel
% Physiological Signal Processing
% Final Exam Part 2 - Compression

%% Question 1.1

%% Load data
close all
clear
clc
load('data.mat');

%% Save metadata
n_channels = height(data);
n_samples = width(data);

%% Reshape
data = reshape(data, [1, n_channels * n_samples]);

%% Get amplitude histogram
[N, edges] = histcounts(data);


%% Plot amplitude histogram
plot(edges(1:end-1), N)
title('1.1 distribution of signal amplitude')

%% Save empiriccal amplitude probabilities
probabilities = N/sum(N);
save('1.1probabilities.mat','probabilities')

%% Question 1.2
% Calculate signal entropy
entropy = -sum(probabilities(probabilities~=0) .* log2(probabilities(probabilities~=0)));
fprintf("1.2 The entropy of the signal is: %f\n", entropy) 

%% Question 1.3
% Apply Huffman coding
probabilities_table = table(edges(1:end-1)', probabilities', 'VariableNames', {'edge_lower', 'probability'});
summary(probabilities_table)

codetree = Huffman(probabilities_table);

codebook = tree2book(codetree);