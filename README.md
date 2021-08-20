# dvsd_pe_1v8 (8 bit Priority Encoder RTL to GDS flow) 
In this project complete RTL to GDS flow has been done for 8 bit Priorty Encoder

# Contents
- [Design Overview](#design-overview )
- [Verilog behavioral design](#verilog-behavioral-design)
- [Openlane](#openlane)
	- [Installation](#installation)
	- [Adding a new design](##adding-new-design)
	- [Setting design configuration](##setting-design-configuration)
	- [Synthesis](##synthesis)
	- [Floorplan](##floorplan)
	- [Placement](##placement)
	- [Routing](##routing)
	- [Final Layout](##final-layout)
- [Pre layout simulation](#pre-layout-simulation)
- [Pre-layout performance](#prelayout-performance)
- [Instant count](#instant-count)
- [Post-layout Area](#post-layout-area)
- [Post-layout simulations](#post-layout-simulations)
- [Steps to reproduce and explore the design](#steps-to-reproduce-and-explore-the-design)
- [Keys to remember](#keys-to-remember)
- [Area of improvement](#area-of-improvement)
- [References](#references)
- [Acknowledgement](#acknowledgement)


## Design Overview

## Verilog behavioral design

## Openlane 

### Installation

### Adding new design

### Setting design configuration

### Synthesis

### Floorplan

### Placement

### Routing

### Final Layout

## Pre layout simulation



### To perform simulation in yout system

 Open terminal in your system (preferred Ubuntu OS)

- `git clone https://github.com/Khalique13/dvsd_pe_1v8.git`
- `cd dvsd_pe_1v8/pre_layout`
- `iverilog -o dvsd_pe dvsd_pe.v test_dvsd_pe.v`
- `./dvsd_pe`
- `gtkwave dvsd_pe.vcd`

### Prelayout Layout simulation

  Terminal snap (To perform pre-layout simulation)
  
  ![pre_layout_sim_ter](https://user-images.githubusercontent.com/80625515/130051278-4923d434-75f6-44ed-88dd-3a2864a3b84b.png)

  GTKWave output waveform
  
  ![pre_layout_sim](https://user-images.githubusercontent.com/80625515/130084221-8654af3a-aaf5-417f-b290-c65f87536778.png)

## Pre-layout performance

## Instant count

## Post-layout Area

## Post-layout simulations

## Steps to reproduce and explore the design

## Keys to remember

## Area of improvement

## References

## Acknowledgement


