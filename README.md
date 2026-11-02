# bme207-lab7-thermistor-activity
Code and instructions for BME207 thermistor activity in Lab 7 - Signal Acquisition. This activity was adapted from an [Adafruit tutorial](https://learn.adafruit.com/thermistor/using-a-thermistor).


## Prerequisites
### Software
- MATLAB installation (tested on R2026b but should work on earlier versions)
- [Arduino IDE](https://support.arduino.cc/hc/en-us/articles/360019833020-Download-and-install-Arduino-IDE) (this is only needed to upload code to the board)
### Hardware
- Breadboard
- 10 $k\Omega$ resistor
- thermistor from Arduino kit: should be a 10k NTC (negative temperature coefficient)

## Instructions
1. Download/clone this repository. 
2. Measure resistance of resistor
3. Measure resistance of thermistor at room temperature
4. In the Arduino code (`Arduino\thermistor_acquisition\thermistor_acquisition.ino`), set the variable `SERIESRESISTOR` to the measurement of **Step 1** and the variable `THERMISTORNOMINAL` to the measurement in **Step 2**
    - Note: While not necessary, setting these values will provide more accurate temperature measurements  
5. Connect the Arduino to your computer and upload the code
    - Troubleshooting: make sure that `thermistor_acquisition.ino` is in a folder titled `thermistor_acquisition`
6. Assemble circuit on breadboard and wire to Arduino (Fig. 1)
    - Note: The analog reference is set to 3.3V here. 5V can also be used with slight variation to the code and circuit. 
    - Question: What would be the benefit of using 3.3V instead of 5V in this case?

![Figure 1. Breadboard diagram](docs/breadboard%20wiring-01.png)
Figure 1. Breadboard Digram

7. Start MATLAB and open up the script `MATLAB\thermistorDemo.m`
    - Troubleshooting: the `com_port` variable on line 12 may need to be manually set if `serialportlist()` doesn' automatically find the Arduino connected to your computer
    - Troubleshooting: make sure that the Serial Monitor/Serial Plotter in th Arduino IDE are closed or MATLAB won't be able to connect to the Arduino
    - Troubleshooting: be sure that `setupPlot.m` is in the same folder as `thermistorDemo.m`
8. Run the script and wait for a figure window to pop up.
    - To start acquiring data from the Arduino run the following command in the Command Window:
    
        `writeline(ard, "Start)`
    - To stop run: 
        
        `writeline(ard, "Stop")`
9. Once acquisition starts, wait for aroun 10 seconds to let the graph fill with data. Stop the acquisition and **report the values in the plots/screenshot the figure**.
10. Next, start the acquisition again. This time, lightly press two fingers around the thermistor and observe any changes that occur in the plots. After the plots are steady, stop the acquisition and **report the values in the plots/screenshot the figure**.
    - Note: I also found it somewhat reliable use use the light on your phone and hold it directly next to the thermistor

