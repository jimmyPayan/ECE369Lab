5-Stage MIPS Pipelined Datapath
This repository contains the Verilog implementation of a 5-stage MIPS pipelined datapath, conceptually designed and implemented using Xilinx Vivado 2022.2. The datapath is optimized to execute 32-bit MIPS instructions, with specific enhancements for the Variable Block Size Motion Estimate (VBSME) algorithm.

Features
5-Stage Pipeline Architecture: Incorporates the classic MIPS pipeline stages - Instruction Fetch (IF), Instruction Decode (ID), Execute (EX), Memory Access (MEM), and Write Back (WB).
Optimized for VBSME: Tailored enhancements to efficiently handle the computational requirements of the Variable Block Size Motion Estimate algorithm.
32-bit MIPS Instruction Set: Supports a wide range of MIPS instructions, enabling the execution of complex algorithms and computations.
Vivado 2022.2 Integration: Developed and tested using the latest Xilinx Vivado tools, ensuring compatibility and performance optimization.

Getting Started
Prerequisites
Xilinx Vivado 2022.2 (or later)
Installation
Clone the repository to your local machine.
git clone https://github.com/your-username/5-stage-mips-datapath.git
Open the project in Vivado by navigating to the project directory and launching Vivado.
Synthesize and implement the design as per the usual Vivado flow.
Usage
The datapath can be used for educational purposes, simulation, and as a base for further enhancements, particularly in the field of motion estimation algorithms.

Contributing
Contributions are welcome. Please open an issue first to discuss what you would like to change or add.

License
Distributed under the MIT License. See LICENSE for more information.

Acknowledgments
Dr. Ali Akoglu and the University of Arizona
Jimmy Payan and Ryan Rathbun
