% OrderedFFT.m: The definition of a function for getting a well-ordered fft

function [X, order] = orderedFFT(signal, sampleFrequency)
% orderedFFT - Gets the fft of a signal based on it's length to avoid aliasing
%
% Syntax: power = getPowerOfSignal(signal, sampleFrequenc)
    m = length(signal); 
    order = pow2(nextpow2(m)); 
    X = fft(signal, order); 
end