
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

%% 2.2a Train Vector Quantization Codebook
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
% Initialize block size
N = 2;
% Build quantization levels (i.e. [4, 8, 16, 32, ..., 512, 1024])
Qs = arrayfun(@pow2, 2:10);
% Initialize distortion measures array
Ds = zeros(size(Qs));
% Calculate distortion measure for each quantization level
for i=1:length(Qs)
    % Get quantization level
    Q = Qs(i);
    % Crop data to multiple time steps of N
    cropped_data = crop(data, N);
    % Encode and Decode data
    reconstructed = VQEncodeDecode(cropped_data, Q, N);
    % Measure distortion measure
    distortion = PRD(cropped_data, reconstructed);
    % Insert distortion measure into Ds
    Ds(i) = distortion;
    fprintf("Q is %d, PRD distortion is %f\n", Q, distortion)
end
% Calculate Bit Rates (bits per sample)
Bs = arrayfun(@(Q) log2(Q)/N, Qs);
% Plot Distortion Measure as function of Bit Rate (bits per sample)
plot(Bs, Ds, '-o')
ylabel("PRD")
xlabel("bits per sample")
title("2.4 Distortion Measure as function of Bit Rate")
print(gcf,'results/2.4distortionsQ.png','-dpng','-r300'); 

%% Question 2.5
% Initialize quantization levels
Q = 128;
% Initialize block sizes
Ns = [1 2 3];
% Initialize distortion measures array
Ds = zeros(size(Ns));
% Calculate distortion measure for each block size
for i=1:length(Ns)
    % Get block size
    N = Ns(i);
    % Crop data to multiple time steps of N
    cropped_data = crop(data, N);
    % Encode and Decode data
    reconstructed = VQEncodeDecode(cropped_data, Q, N);
    % Measure distortion measure
    distortion = PRD(cropped_data, reconstructed);
    % Insert distortion measure into Ds
    Ds(i) = distortion;
    fprintf("N is %d, PRD distortion is %f\n", N, distortion)
end

% Calculate Bit Rates (bits per sample)
Bs = arrayfun(@(N) log2(Q)/N, Ns);
% Plot Distortion Measure as function of Bit Rate (bits per sample)
plot(Bs, Ds, '-o')
ylabel("PRD")
xlabel("bits per sample")
title("2.5 Distortion Measure as function of Bit Rate")
print(gcf,'results/2.5distortionsN.png','-dpng','-r300'); 

%% Question 2.6
tiledlayout(3,1)
%Top Plot
ax1 = nexttile;
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
% Plot Reconstructed Version
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
% Plot Reconstructed Version
plotEEG_to_ax(ax3, reconstructed, 512, sprintf("reconstructed Q=%d, N=%d", Q, N));
print(gcf,'results/2.6Comparison.png','-dpng','-r300'); 

%% Question 2.7
tiledlayout(3,1)
%Top Plot
ax1 = nexttile;
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
% Plot Reconstructed Version
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
% Plot Reconstructed Version
plotEEG_to_ax(ax3, reconstructed, 512, sprintf("reconstructed Q=%d, N=%d", Q, N));
print(gcf,'results/2.7Comparison.png','-dpng','-r300'); 

%% End message
fprintf("success\n")
