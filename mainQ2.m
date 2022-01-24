
%% Question 2.1
% Noam Siegel
% January 24, 2022

%% Make results directory
mkdir('results')

%% Turn off kmeans warning
% turning this off is allowed because we are not seeking kmeans convergence
warning('off', 'stats:kmeans:FailedToConverge')

%% Clear environment
close all
clear
clc

%% Load data
load('data.mat');

%% Quantize data
data = quantize(data, 2^12);

%% 2.2a Train Vector Quantization Codebook
fprintf("2.2a\n")
% Initialize block size
N = 2;
% Initialize quantization level
Q = 16;
% crop and flatten data
cropped_data = crop(data, N);
% get VQ codebook
codebook = trainVQ(cropped_data, Q, N);
% reshape data into blo cks of size N
blocked_data = reshape(cropped_data.', N, []).';
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
print(gcf,'results/2.2.a.voronoi.png','-dpng','-r300'); 

%% 2.2b Train Vector Quantization Codebook
fprintf("2.2b\n")
% Initialize block size
N = 2;
% Initialize quantization level
Q = 128;
% crop and flatten data
cropped_data = crop(data, N);
% get VQ codebook
codebook = trainVQ(cropped_data, Q, N);
% reshape data into blocks of size N
blocked_data = reshape(cropped_data.', N, []).';
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
print(gcf,'results/2.2.b.voronoi.png','-dpng','-r300'); 

%% Question 2.4
fprintf("2.4\n")
% Initialize block size
N = 2;
% Build quantization levels (i.e. [4, 8, 16, 32, ..., 512, 1024])
Qs = arrayfun(@pow2, 2:10);
% Initialize distortion measures arrays
PRDs = zeros(size(Qs));
MXDs = zeros(size(Qs));
% Calculate distortion measure for each quantization level
for i=1:length(Qs)
    % Get quantization level
    Q = Qs(i);
    % Crop data to multiple time steps of N
    cropped_data = crop(data, N);
    % Encode and Decode data
    reconstructed = VQEncodeDecode(cropped_data, Q, N);
    % Measure PRD distortion
    prd = PRD(cropped_data, reconstructed);
    % Measure pairwise max-cross-correlation distortion
    mxd = maxxcorrDistortion(cropped_data, reconstructed);
    % Insert distortion measure into Ds
    PRDs(i) = prd;
    MXDs(i) = mxd;
    fprintf("Q is %d, PRD is %f, MXD is %f\n", Q, prd, mxd)
end
% Calculate Bit Rates (bits per sample)
Bs = arrayfun(@(Q) log2(Q)/N, Qs);
% Plot Distortion Measures as function of Bit Rate (bits per sample)
plot(Bs, PRDs, '-o')
ylabel("PRD")
yyaxis right
plot(Bs, MXDs, '-^')
ylabel("MXD")
xlabel("bits per sample")
title("2.4 Distortion Measures as function of Bit Rate")
print(gcf,'results/2.4distortionsQ.png','-dpng','-r300');

%% Question 2.5
fprintf("2.5\n")
% Initialize quantization levels
Q = 128;
% Initialize block sizes
Ns = [1 2 3];
% Initialize distortion measures arrays
PRDs = zeros(size(Qs));
MXDs = zeros(size(Qs));
% Calculate distortion measure for each block size
for i=1:length(Ns)
    % Get block size
    N = Ns(i);
    % Crop data to multiple time steps of N
    cropped_data = crop(data, N);
    % Encode and Decode data
    reconstructed = VQEncodeDecode(cropped_data, Q, N);
    % Measure PRD distortion
    prd = PRD(cropped_data, reconstructed);
    % Measure pairwise max-cross-correlation distortion
    mxd = maxxcorrDistortion(cropped_data, reconstructed);
    % Insert distortion measure into Ds
    PRDs(i) = prd;
    MXDs(i) = mxd;
    fprintf("Q is %d, PRD is %f, MXD is %f\n", Q, prd, mxd)
end

% Calculate Bit Rates (bits per sample)
Bs = arrayfun(@(N) log2(Q)/N, Ns);
% Plot Distortion Measures as function of Bit Rate (bits per sample)
plot(Bs, PRDs, '-o')
ylabel("PRD")
yyaxis right
plot(Bs, MXDs, '-^')
ylabel("MXD")
xlabel("bits per sample")
title("2.4 Distortion Measures as function of Bit Rate")
print(gcf,'results/2.4distortionsQ.png','-dpng','-r300');

%% Question 2.6
fprintf("2.6\n")
tiledlayout(3,1)
%Top Plot
ax1 = nexttile;
% Plot original data
plotEEG_to_ax(ax1, data, 512, "original zscored EEG");

%Middle plot
ax2 = nexttile;
% Set VQ compression parameters
N = 2;
Q = 2^4;
% Crop data to multiple time steps of N
cropped_data = crop(data, N);
% Encode and Decode data
reconstructed = VQEncodeDecode(cropped_data, Q, N);
% Plot reconstructed data
plotEEG_to_ax(ax2, reconstructed, 512, sprintf("reconstructed Q=%d, N=%d", Q, N));

%Bottom plot
ax3 = nexttile;
% Set VQ compression parameters
N = 2;
Q = 2^7;
% Crop data to multiple time steps of N
cropped_data = crop(data, N);
% Encode and Decode data
reconstructed = VQEncodeDecode(cropped_data, Q, N);
% Plot reconstructed data
plotEEG_to_ax(ax3, reconstructed, 512, sprintf("reconstructed Q=%d, N=%d", Q, N));
print(gcf,'results/2.6Comparison.png','-dpng','-r300'); 

%% Question 2.7
fprintf("2.7\n")
tiledlayout(3,1)
%Top Plot
ax1 = nexttile;
% Plot original data
plotEEG_to_ax(ax1, data, 512, "original zscored EEG");

%Middle plot
ax2 = nexttile;
% Set VQ compression parameters
N = 2;
Q = 2^7;
% Crop data to multiple time steps of N
cropped_data = crop(data, N);
% Encode and Decode data
reconstructed = VQEncodeDecode(cropped_data, Q, N);
% Plot reconstructed data
plotEEG_to_ax(ax2, reconstructed, 512, sprintf("reconstructed Q=%d, N=%d", Q, N));

%Bottom plot
ax3 = nexttile;
% Set VQ compression parameters
N = 3;
Q = 2^7;
% Crop data to multiple time steps of N
cropped_data = crop(data, N);
% Encode and Decode data
reconstructed = VQEncodeDecode(cropped_data, Q, N);
% Plot reconstructed data
plotEEG_to_ax(ax3, reconstructed, 512, sprintf("reconstructed Q=%d, N=%d", Q, N));
print(gcf,'results/2.7Comparison.png','-dpng','-r300'); 

%% End message
fprintf("success\n")
