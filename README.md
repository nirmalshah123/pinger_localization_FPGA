# Pinger Localization using FPGA

This project focuses on localizing a pinger (acoustic emitter) to help an Autonomous Underwater Vehicle (AUV) navigate underwater. The goal is to replace expensive, slow, and platform-incompatible software-based pinger detection systems with a high-speed, low-cost FPGA-based solution.

## Project Overview

- Pingers emit sound waves at frequencies between **25-45kHz**.
- Four hydrophones are used detect these signals.
- We have used an algorithm simmilar to **Time Difference of Arrival (TDOA)** for signal processing.
- This work uses **FPGA (Zybo Z7-20)** to accelerate the signal detection and localization tasks.

## Objective

To implement the pinger detection pipeline on FPGA to:

- Eliminate costly **DAQ** systems (~₹1.5L) in favor of **FPGA (~₹30k)**.
- Build a **scalable**, modular system that can be reused in sonar and acoustic systems.

## Achievements

- Achieved **~95.8%** reduction in processing time(From 4s in software to 0.165s in Hardware(FPGA)).
- Successfully simulated full pipeline on FPGA.
- Developed multiple IP blocks for detection and analysis.

## Tools & Libraries

- **Vivado Design Suite**
- **Xilinx FFT IP Core**
- **AXI4 Stream Protocol**
- **Custom IPs**

## References

- [Here](https://drive.google.com/file/d/1CggZDJSdUsD7FZXWV6njr6QxX8ftU1rM/view) is the algorithm which is used for Pinger Localization
- The collab notebook used for the above code is [here](https://colab.research.google.com/drive/1zq0cF1qQg30Y6dY3l6lmDWPKzVIs0esH).

Here is a small flowchart of the entire algorithm
<img src="Algorithm_flowchart.png" style="border: 2px solid  gray;">


## Files
All the source code can be found in tcl_files folder.

To generate the entire project just run the following command

<pre><code>source final_backup.tcl</code></pre>