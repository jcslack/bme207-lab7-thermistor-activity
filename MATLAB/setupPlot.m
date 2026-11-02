function plotHandle = setupPlot(window_len)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%window_len = 20; %number of average readings to display
x = 1:1:window_len;
y = zeros(window_len, 1);
plotHandle = struct("axA", [], "axR", [], "axV", [], "axT", [], "window_len", window_len);
figure;
tiledlayout(4,1, "TileSpacing", "tight");

nexttile;
axA = plot(x, y, "LineWidth", 1.5);
title("Analog Reading")
ylabel("ADC Value")
xlim([1 window_len])
ylim([400 600])

nexttile
axR = plot(x, y, "LineWidth", 1.5);
title("Thermistor Resistance")
ylabel("Ohms")
xlim([1 window_len])
ylim([8000 12000])

nexttile
axV = plot(x, y, "LineWidth", 1.5);
title("Output Voltage")
ylabel("Volts")
xlim([1 window_len])
ylim([0 4])

nexttile
axT = plot(x, y, "LineWidth", 1.5);
title("Temperature")
ylabel("Celcius")
xlabel("Samples")
xlim([1 window_len])
ylim([15 35])

plotHandle.axA = axA;
plotHandle.axR = axR;
plotHandle.axV = axV;
plotHandle.axT = axT;
end