# Traffic Light Controller using Verilog HDL

![Verilog](https://img.shields.io/badge/HDL-Verilog-blue)
![FSM](https://img.shields.io/badge/Design-Finite_State_Machine-green)
![Simulation](https://img.shields.io/badge/Simulation-Icarus_Verilog-orange)
![Waveform](https://img.shields.io/badge/Waveform-GTKWave-purple)

## Overview

A Verilog implementation of an intelligent two-road traffic light controller based on a Finite State Machine (FSM). The controller dynamically switches traffic signals according to vehicle presence on each road and includes configurable timing for green and yellow light durations.

The project also includes a simulation testbench for functional verification and waveform analysis using GTKWave.

## Features

* FSM-based traffic signal control
* Two independent vehicle detection inputs
* Automatic traffic switching logic
* Green, Yellow, and Red signal encoding
* Adjustable signal timing parameters
* Simulation-ready testbench
* VCD waveform generation for debugging
* Synthesizable RTL design

## State Diagram

The controller operates through four traffic states:

| State | Road 1 | Road 2 |
| ----- | ------ | ------ |
| G1R2  | Green  | Red    |
| Y1R2  | Yellow | Red    |
| R1G2  | Red    | Green  |
| R1Y2  | Red    | Yellow |

State transitions are determined by:

* Vehicle presence on Road 1 (`vech1`)
* Vehicle presence on Road 2 (`vech2`)
* Internal timing counters

## Project Structure

```text
.
├── trafficLight.v        # Traffic light controller RTL
├── tb_trafficLight.v     # Testbench
├── trafficLight.vcd      # Simulation waveform output
└── README.md
```

## Signal Description

### Inputs

| Signal | Width | Description                 |
| ------ | ----- | --------------------------- |
| clk    | 1     | System clock                |
| rst    | 1     | Active-high reset           |
| vech1  | 1     | Vehicle detector for Road 1 |
| vech2  | 1     | Vehicle detector for Road 2 |

### Outputs

| Signal | Width | Description               |
| ------ | ----- | ------------------------- |
| light1 | 3     | Traffic signal for Road 1 |
| light2 | 3     | Traffic signal for Road 2 |

### Light Encoding

| Value  | Meaning |
| ------ | ------- |
| 3'b100 | Green   |
| 3'b010 | Yellow  |
| 3'b001 | Red     |

## How It Works

1. System starts in the `G1R2` state.
2. Road 1 receives a green signal while Road 2 remains red.
3. If traffic is detected on Road 2, the controller eventually transitions:

   * `G1R2 → Y1R2`
   * `Y1R2 → R1G2`
4. Road 2 then receives the green signal.
5. After the configured timer expires, control switches back to Road 1.
6. Yellow states provide a safe transition between green and red phases.

## Getting Started

### Prerequisites

Install:

* Icarus Verilog
* GTKWave

### Ubuntu

```bash
sudo apt update
sudo apt install iverilog gtkwave
```

### Verify Installation

```bash
iverilog -V
gtkwave --version
```

## Running the Simulation

### Compile

```bash
iverilog -o sim trafficLight.v tb_trafficLight.v
```

### Execute

```bash
vvp sim
```

Expected output:

```text
VCD info: dumpfile trafficLight.vcd opened for output.
```

### Open Waveform

```bash
gtkwave trafficLight.vcd
```

## Example Test Sequence

The provided testbench verifies:

```text
Reset asserted
↓
Vehicle on Road 2
↓
Vehicle on Road 1
↓
Vehicles on both roads
↓
No vehicles
↓
Reset again
```

These scenarios validate FSM transitions and timing behavior.

## Synthesis

The RTL is fully synthesizable and can be used with synthesis tools such as:

* Yosys
* Vivado
* Quartus Prime

Example:

```bash
yosys

read_verilog trafficLight.v
hierarchy -top trafficLight
synth
write_verilog trafficLight_netlist.v
```

## Customization

Timing values can be modified inside the controller:

```verilog
localparam timer = 4'b0101;
localparam delay = 4'b0001;
```

### Purpose

* `timer` → Green light duration
* `delay` → Yellow light duration

Adjust these values according to simulation or deployment requirements.

## Expected Waveform Signals

Monitor the following signals in GTKWave:

```text
clk
rst
vech1
vech2
current
next
count
light1
light2
```

These signals provide complete visibility into FSM behavior.

## Contributing

Contributions are welcome.

Typical improvements include:

* Pedestrian crossing support
* Emergency vehicle priority
* Configurable timing registers
* Multi-lane traffic management
* Sensor debouncing
* Formal verification

Please submit a pull request with a clear description of the proposed enhancement.

## Maintainer

**Puspa Kamal Rai**
Department of Physics
Sri Sathya Sai Institute of Higher Learning (SSSIHL)

## Support

For questions or project discussions:

* Open a GitHub Issue
* Review simulation waveforms
* Inspect FSM state transitions in the RTL source

## Future Enhancements

* Adaptive traffic control
* FPGA deployment
* Traffic density estimation
* AI-assisted signal optimization
* Real-time sensor integration

## License

This project is distributed under the terms specified in the repository's LICENSE file.
