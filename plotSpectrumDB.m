% plotSpectrumDB.m: Definition of a function for plotting the db power of a signal

function output = plotSpectrumDB(HW)
%plotSpectrumDB - plots the power spectrum of a signal in dB
%
% Syntax: output = plotSpectrumDB(signal)
    len = length(HW);
    HWdB = 20 * log10(abs(HW));
    HWdB2 = HWdB(1:len / 2);
    n1 = 0:1:(len / 2) - 1;

    f = figure;
    p = plot(n1 / len, HWdB2);

    axis([0,.5]);
    title("Filter Magnitude in dB");
    xlabel("Normalized Frequency");
    ylabel("dB");
    output = p;
end