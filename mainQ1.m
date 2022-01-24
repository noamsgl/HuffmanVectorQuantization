%% Question 1.1
% Noam Siegel
% January 24, 2022
print("1.1")

%% Make results directory
mkdir('results')

%% Load data
close all
clear
clc
load('data.mat');

%% Save signal shape
n_channels = height(data);
n_samples = width(data);

%% Reshape
data = reshape(data, [1, n_channels * n_samples]);

%% Get amplitude histogram
% Quantize into 2^12 levels (12 bits)
num_levels = 2^12;
edges = min(data):(max(data)-min(data))/(num_levels):max(data);
[N, edges] = histcounts(data, edges);
fprintf("1.1 The average bitsize per sample: %f\n", log2(num_levels)) 

%% Plot amplitude histogram
figure('Name', '1.1 Amplitude Histogram')
plot(edges(1:end-1), N)
title('1.1 distribution of signal amplitude')
print(gcf,'results/1.1signalhistogram.png','-dpng','-r300'); 

%% Save empiriccal amplitude probabilities
probabilities = N/sum(N);
save('results/1.1probabilities.mat','probabilities')

%% Question 1.2
print("1.2")
% Calculate signal entropy
entropy = -sum(probabilities(probabilities~=0) .* log2(probabilities(probabilities~=0)));
fprintf("1.2 The entropy of the signal is: %f\n", entropy) 

%% Question 1.3
print("1.3")
% Initialize probabilities table
probabilities_table = table(edges(1:end-1)', probabilities', 'VariableNames', {'lower_edge', 'probability'});

% Print probability statistics
%summary(probabilities_table)

% Apply Huffman coding
codetree = Huffman(probabilities_table);

% Parse codetree to codebook
codebook = tree2book(codetree);

% Save codebook to file
writetable(struct2table(codebook), 'results/1.3huffmancodebook.csv')

% Plot code length as function of bin edge
figure('Name', '1.3 Huffman Code Word Lengths')
code_lengths = num2cell(cellfun(@length, {codebook.code}));
[codebook.code_length] = code_lengths{:};
ylabel('Frequency');
plot(edges(1:end-1), N)
yyaxis right
scatter([codebook.lower_edge], [codebook.code_length], '^', 'r')
xlabel('Signal Amplitude (mV)');
ylabel('Code Word Length (bits)');
title('1.3 Huffman Code Lengths')
print(gcf,'results/1.3huffmanlengths.png','-dpng','-r300'); 

%% Question 1.4
print("1.4")
% Calculate Huffman Encoded Signal Bitsize
% Sort by amplitude (lower_edge)
codebook_table = struct2table(codebook);
codebook_table = sortrows(codebook_table, 'lower_edge');

% Calculate average 
average_length = sum((N' .* codebook_table.code_length))/sum(N);
fprintf("1.4 The average Huffman encoded word length is: %f\n", average_length) 

%% End message
fprintf("success\n")

