% buildLowPassFilter.m: Definition of a function for building a configurable low pass filter

function lowpassFilter = buildLowPassFilter(a0, fc, fs, M, m1)
% buildLowPassFilter - Build a low pass filter using a configurable hann window
%
% Syntax: buildFilter = filter(A0, cutoff frequency, sampling frequency, filter order, fft order)

    fcNorm = fc / fs;
    n = 0:1:M;
    w = a0 - ((1 - a0) .* cos(2 * n * pi / M));
    hd = (2 * fcNorm * sinc(2 * fcNorm * (n - (M / 2))));
    hw = hd .* w;
    lowpassFilter = fft(hw, m1);
end