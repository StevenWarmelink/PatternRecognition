%% Assignment 5
clear all;
close all;
format long;

% Read audio file, save data in y and 
% sample rate in Fs
[y, Fs] = audioread('corrupted_voice.wav'); 

% Transform signal to fourier domain
X = fft(y);
% Calculate frequency resolution:
% Sampling Frequency over number of samples
DFT_res = Fs / length(y);
% Create frequency vector (for x-axis)
freqVec = 0:DFT_res:Fs-0.5;

% Look at frequencies with highest amplitude
[B, I] = sort(X,'descend');
% And save the top 5
bestFive = freqVec(I(1:5));

% In the frequency range [0 11000] Hz, the 
% two biggest peaks are 99.9 Hz and 6000.1 Hz

% plot in different ranges
figure();
subplot(2,1,1);
plot(freqVec,real(X));
title('Frequency Spectrum in frequency range [0 11000]');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
xlim([0 11000]);

subplot(2,1,2);
plot(freqVec,real(X));
title('Frequency Spectrum in frequency range [0 500]');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
xlim([0 500]);

%% Filter out frequencies
% The peak at frequency 6K Hz should be removed. We use 
% a Butterworth transfer function which we can use 
% to filter out unwanted frequencies. We use a low-
% pass filter to keep everything under 2 KHz intact, 
% and decrease the amplitude of everything afterwards

% Load audiofile
[y, Fs] = audioread('corrupted_voice.wav');

% Create transfer funtion.
[b, a] = butter(7, 2000/(Fs/2));
% Filter original audio with butterworth and transfer
% function above.
filtered_audio = filter(b, a, y);

% Write to file. 
audiowrite('cleaned_voice.wav',filtered_audio,Fs);