%%
% The sample rate can be approximated based on the NUMSAMPLES value in the 
% Arduino code and the delay used between analog reads. The average of 
% NUMSAMPLES readings are used to calculate temperature and then sent 
% to MATLAB over the serial port. 
% In this case NUMSAMPLES=5 with a delay of 10ms between reads so the
% sample rate is approximately:
% fs = 1/(5 * 10e-3) = 20Hz (20 samples/second)
window_len = 100; %number of samples displayed in plots at a given time. 

h = setupPlot(window_len); %plots
com_port = serialportlist(); %this assumes that the Arduino is the only serial port device connected to you computer (e.g "COM4"/"COM#" on windows)
ard = serialport(com_port, 9600); %serial port object

ard.UserData.cnt = 0; % counter for tracking number of samples acquired
configureTerminator(ard, "CR/LF"); % how line endings are handled
flush(ard);
configureCallback(ard, "terminator", @(src, event)plotArduinoData(src, event, h)); % function to be called when serial port object sees CR/LF on the serial port

%% To start acquiring data
% writeline(ard, "Start")

%% To stop acquireing data
% writeline(ard, "Stop")

%% callback function. 
% This function is called whenever a Serial.println() occurs on the Arduino 
% Example line of data that is sent by the arduino:
% "AnalogReading,548.00;Resistance,11398.40;SeriesVoltage,1.77;Temperature,22.80"
% 
% The format is <Type of reading>,<Value>;<Type of reading>,Value;...
% Each type of reading (e.g. resistance, temperature, etc) are separated by
% semi-colons. 
function plotArduinoData(src, ~, h)

    dataNew = readline(src);
    dataNew = split(split(dataNew, ";"), ","); % separate each reading and value of the reading
    % dataNew is (4x2). First column is the name of the reading, second
    % column are the corresponding values.
    cnt = src.UserData.cnt + 1; % increment count
    allH = [h.axA, h.axR, h.axV, h.axT];
    yCurrent = cell2mat(get(allH, "YData"));
    % the following is basically a scrolling plot. old data is replaced
    % with new data instead of just being added to reduce memory load.
    if cnt > h.window_len
        xCurrent = get(h.axA, "XData");
        xCurrent = [xCurrent(2:end), xCurrent(end) + 1];
        set(allH, "XData", xCurrent);
        set([allH.Parent], "XLim", [xCurrent(1) xCurrent(end)]);
        yCurrent = [yCurrent(:,2:end) str2double(dataNew(:,2))];
    else
        yCurrent(:,cnt) = str2double(dataNew(:,2));
    end
    ylim_vals =  [min(yCurrent, [], 2)*0.89 max(yCurrent, [], 2)*1.1];
    set(allH, {"YData"}, num2cell(yCurrent, 2));
    set([allH.Parent], {"YLim"}, num2cell(ylim_vals, 2))
    drawnow limitrate
    src.UserData.cnt = cnt;

end