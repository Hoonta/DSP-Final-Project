% Main.m: Implementation of the driver code for the filtering of our sample
%% FIR Filter
clear all;

% Grab audio data from clip
[audioData,samplingFrequency] = audioread('Pre_FIR_FeelItStill.wav');

% Get the frequency spectrum of the signal, making sure the order of the fft
%   is sufficient to avoid aliasing
[X, order] = orderedFFT(audioData, samplingFrequency);

% Calculate the mapping of the normalized frequency domain to the frequency domain 
f = (0: order - 1) * (samplingFrequency / order);

% Draw original Signal
power = abs(X) .^ 2 / order;
figure;
plot(f(1: floor(order / 2)), power(1: floor(order / 2)));
axis([0, 6000])
xlabel('Frequency (Hz)');
ylabel('Power');
title('Power Spectrum of Original Line from "Feel It Still"')

% Build a low pass filter to specification
HW = buildLowPassFilter(.54, 1100, samplingFrequency, 100, order);

% Plot spectrum of filter in dB
filterPlot = plotSpectrumDB(HW);

% Apply the filter
filteredFrequencyData = X .* (HW.');

% Calculate the power of the signal
power = abs(filteredFrequencyData).^2/order;


% Draw Filtered Signal
figure; 
plot(f(1:floor(order/2)),power(1:floor(order / 2))); 
axis([0,6000]);
xlabel('Frequency (Hz)'); 
ylabel('Power');
title('Power Spectrum of Filtered Bass Line from "Feel It still"');  

% Get filtered signal back to time domain
filteredAudioData = ifft(filteredFrequencyData, order);

% Write output to file
audiowrite("Post_FIR_FeelItStill.wav", filteredAudioData, samplingFrequency);

%% IIR Filter
clear all, clc, close all;

%Grab the audio data from clip
[x, Fs]=audioread('Pre_IIR_FeelItStill.wav');

% Get the frequency spectrum of the signal, making sure the order of the fft
%   is sufficient to avoid aliasing
[X, order] = orderedFFT(x, Fs);

% Calculate the mapping of the normalized frequency domain to the frequency domain 
f = (0: order - 1) * (Fs / order);

% Draw original Signal
power = abs(X) .^ 2 / order;
figure;
plot(f(1: floor(order / 2)), power(1: floor(order / 2)));
xlim([0, 6000])
xlabel('Frequency (Hz)');
ylabel('Power');
title('Power Spectrum of Original Line from "Feel It Still"')

%Design of the IIR filter
%zeros poles and gain were used to circumvent matlab having numberical
%errors when designing high order filters.
[z,p,k] = cheby2(12,50,800/(Fs/2),'high');
[sos,g] = zp2sos(z,p,k);    %Secord order sections form
fvt = fvtool(sos,'Fs',Fs);  %Graph of the filter in DB
xlim([0 6]);                %0-6kHz x axis
y=filtfilt(sos,g,x);        %Filter the input signal

%write the audio to a file
audiowrite('PostIIR_FeelItStill.wav',y,Fs);

%Calculate the power of the filtered signal
Y = abs(y).^2/order;

% Calculate the mapping of the normalized frequency domain to the frequency domain 
f = (0: order - 1) * (Fs / order);

% Draw Signal
figure; 
plot(f(1:floor(order/2)),Y(1:floor(order / 2))); 
xlim([0,6000]);
xlabel('Frequency (Hz)'); 
ylabel('Power');
title('Power Spectrum of Filtered Bass Line from "Feel It still"');  