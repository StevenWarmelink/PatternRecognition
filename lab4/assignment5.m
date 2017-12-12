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
% And print the top 5
freqVec(I(1:5))

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

clear all;
close all;

% The peaks at 100 Hz and 6K Hz should be removed, 
% along with their overtones (if applicable).

% We can easily limit ourselves to the frequency 
% range of [0 36000] Hz and still have great 
% voice quality. Hence we will do so. ( 

% Load audiofile
[y, Fs] = audioread('corrupted_voice.wav');

% Take DFT of signal
X = fft(y);

% Calculate frequency resolution:
% Sampling Frequency over number of samples
DFT_res = Fs / length(y);
% Create frequency vector 
freqVec = 0:DFT_res:Fs-0.5;


% NOTE:: NO LONGER USED; COULD NOT GET BUTTER TO WORK =(
% (OR AT LEAST NOT AS WELL AS JUST SETTING FREQs TO 0)
%[b_high, a_high] = butter(12, 3000/(Fs/2),'low');
%high_idx = min(find(freqVec > 3000));
%high = filter(b_high, a_high, X);
%X(high_idx:end) = high(high_idx:end);

% Set amplitudes in range [95 105] and [5500 6500] to 0.
X(find(freqVec > 95 & freqVec < 105)) = 0;
X(find(freqVec > 5500 & freqVec < 6500)) = 0;

% Set all amplitudes of frequencies over 36000 to 0.
max_freq = find(freqVec > 36000);
X(max_freq:end) = 0;

% Plot to verify
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

% Do inverse fft on "cleaned up" signal
decorrupted_audio = ifft(X);

% Write to file. 
audiowrite('cleaned_voice.wav',decorrupted_audio,Fs);
