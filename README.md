# 8 bit Priority Encoder (dvsd_pe) RTL2GDS flow using SKY130 pdks
*The purpose of this project is to produce clean GDS (Graphic Design System) Final Layout with all details that is used to print photomasks used in fabrication of a behavioral RTL (Register-Transfer Level) of an 8 bit Priorty Encoder, using SkyWater 130 nm PDK (Process Design Kit)*

# Table of Contents
- [Design Overview](#design-overview)
- [IP specs Provided](#ip-specs-provided)
- [Verilog behavioral design](#verilog-behavioral-design)
- [OpenLane](#openlane)
	- [Installation](#installation)
	- [Running OpenLane](#running-openlane)
	- [Synthesis](#synthesis)
	- [Floorplanning Placement and Routing ](#floorplanning-placement-and-routing)
	- [Routing](#routing)
	- [Final Layout](#final-layout)
- [Pre-layout](#pre-layout)
	- [Simulation](#simulation)
	- [Performance](#performance)
- [Post-layout](#post-layout)
	- [Synthesis](#synthesis)
	- [Simulation](#simulation)
- [Instant count](#instant-count)
- [Steps to reproduce and explore the design](#steps-to-reproduce-and-explore-the-design)
- [Keys to remember](#keys-to-remember)
- [Area of improvement](#area-of-improvement)
- [References](#references)
- [Acknowledgement](#acknowledgement)


### Design Overview

![Slide2](https://user-images.githubusercontent.com/80625515/130179293-b7b03b4c-2feb-40a6-814a-31af06acc3cd.PNG)

### IP specs provided

![Slide4](https://user-images.githubusercontent.com/80625515/130180121-a4e5d529-bb6d-4ed3-a265-aad5030f82f7.PNG)

### Verilog behavioral design

## OpenLane 

OpenLane is an automated RTL to GDSII flow based on several components including OpenROAD, Yosys, Magic, Netgen, Fault and custom methodology scripts for design exploration and optimization.
For more information check [here](https://openlane.readthedocs.io/)

### Installation

#### Prerequisites
At a minimum:

- Docker 19.03.12+
- GNU Make
- Python 3.6+ with PIP
- Click, Pyyaml: `pip3 install pyyaml click`

```
git clone https://github.com/The-OpenROAD-Project/OpenLane.git
cd OpenLane/
make openlane
make pdk
make test # This a ~5 minute test that verifies that the flow and the pdk were properly installed
```

For detailed installation process, check [here](https://github.com/The-OpenROAD-Project/OpenLane)

### Running OpenLane

`make mount`
- Note
	- Default PDK_ROOT is $(pwd)/pdks. If you have installed the PDK at a different location, run the following before `make mount`:
	- Default IMAGE_NAME is efabless/openlane:current. If you want to use a different version, run the following before `make mount`:

The following is roughly what happens under the hood when you run `make mount` + the required exports:

```
export PDK_ROOT=<absolute path to where skywater-pdk and open_pdks will reside>
export IMAGE_NAME=<docker image name>
docker run -it -v $(pwd):/openLANE_flow -v $PDK_ROOT:$PDK_ROOT -e PDK_ROOT=$PDK_ROOT -u $(id -u $USER):$(id -g $USER) $IMAGE_NAME
```

You can use the following example to check the overall setup:

`./flow.tcl -design spm`

To run openlane in interactive mode

`./flow.tcl -interactive`

![openlane_interactive](https://user-images.githubusercontent.com/80625515/130196432-7e20d103-ce86-4a9c-8a10-757f3bf26e0c.png)

### Synthesis

Steps to explore synthesis of the design

```
make mount
flow.tcl -design dvsd_pe -synth_explore
```

![synth_explore](https://user-images.githubusercontent.com/80625515/130225635-8bee797c-dcf3-445f-9b02-b197dd2c3b39.png)


```

- Printing statistics.

=== dvsd_pe ===

   Number of wires:                 53
   Number of wire bits:             64
   Number of public wires:           5
   Number of public wire bits:      14
   Number of memories:               0
   Number of memory bits:            0
   Number of processes:              0
   Number of cells:                 55
     $_ANDNOT_                      10
     $_AND_                          1
     $_DLATCH_N_                     3
     $_NAND_                         3
     $_NOR_                          4
     $_ORNOT_                        9
     $_OR_                          25


```

``` 

- Printing statistics.

=== dvsd_pe ===

   Number of wires:                 35
   Number of wire bits:             44
   Number of public wires:           5
   Number of public wire bits:      14
   Number of memories:               0
   Number of memory bits:            0
   Number of processes:              0
   Number of cells:                 35
     sky130_fd_sc_hd__a21oi_2        1
     sky130_fd_sc_hd__a2bb2o_2       1
     sky130_fd_sc_hd__a31o_2         1
     sky130_fd_sc_hd__buf_1          5
     sky130_fd_sc_hd__dlxtn_1        3
     sky130_fd_sc_hd__inv_2          8
     sky130_fd_sc_hd__o21ai_2        1
     sky130_fd_sc_hd__o22a_2         2
     sky130_fd_sc_hd__o22ai_2        1
     sky130_fd_sc_hd__o2bb2a_2       1
     sky130_fd_sc_hd__o41a_2         2
     sky130_fd_sc_hd__or2_2          1
     sky130_fd_sc_hd__or3_2          2
     sky130_fd_sc_hd__or4_2          4
     sky130_fd_sc_hd__or4b_2         2

   Chip area for module '\dvsd_pe': 276.515200


```


- Yosys synthesis strategies

![synth1](https://user-images.githubusercontent.com/80625515/130226001-21fe0cbe-5a63-4444-9844-08fc22b9c19d.png)
![synthesis](https://user-images.githubusercontent.com/80625515/130226013-809dac5c-563e-46e7-85b4-c83feb46587c.png)


### Floorplanning Placement and Routing

``` 

[INFO ODB-0223]     Created 13 technology layers
[INFO ODB-0224]     Created 25 technology vias
[INFO ODB-0225]     Created 441 library cells
[INFO ODB-0226] Finished LEF file:  /openLANE_flow/designs/dvsd_pe/runs/20-08_11-32/tmp/merged_unpadded.lef
[INFO ODB-0127] Reading DEF file: /openLANE_flow/designs/dvsd_pe/runs/20-08_11-32/results/floorplan/dvsd_pe.floorplan.def
[INFO ODB-0128] Design: dvsd_pe
[INFO ODB-0130]     Created 14 pins.
[INFO ODB-0131]     Created 64 components and 361 component-terminals.
[INFO ODB-0133]     Created 42 nets and 119 connections.
[INFO ODB-0134] Finished DEF file: /openLANE_flow/designs/dvsd_pe/runs/20-08_11-32/results/floorplan/dvsd_pe.floorplan.def
[INFO PDN-0016] Power Delivery Network Generator: Generating PDN
  config: /home/khalique/openlane/OpenLane/pdks/sky130A/libs.tech/openlane/common_pdn.tcl
[INFO PDN-0008] Design Name is dvsd_pe
[INFO PDN-0009] Reading technology data
[INFO PDN-0011] ****** INFO ******
Type: stdcell, grid
    Stdcell Rails
      Layer: met1  -  width: 0.480  pitch: 2.720  offset: 0.000 
    Straps
      Layer: met4  -  width: 1.600  pitch: 7.708  offset: 3.854 
      Layer: met5  -  width: 1.600  pitch: 11.042  offset: 5.521 
    Connect: {met4 met5} {met1 met4}
Type: macro, macro_1
    Macro orientation: R0 R180 MX MY R90 R270 MXR90 MYR90
    Straps
    Connect: {met4_PIN_ver met5}
[INFO PDN-0012] **** END INFO ****
[INFO PDN-0013] Inserting stdcell grid - grid
[INFO PDN-0015] Writing to database
[WARNING PSM-0016] Voltage pad location (vsrc) file not specified, defaulting pad location to checkerboard pattern on core area.
[WARNING PSM-0017] X direction bump pitch is not specified, defaulting to 140um.
[WARNING PSM-0018] Y direction bump pitch is not specified, defaulting to 140um.
[WARNING PSM-0019] Voltage on net VPWR is not explicitly set.
[WARNING PSM-0022] Using voltage 1.800V for VDD network.
[WARNING PSM-0063] Specified bump pitches of 140.000 and 140.000 are less than core width of 23.000 or core height of 32.640. Changing bump location to the center of the die at (11.500, 16.320)
[WARNING PSM-0065] VSRC location not specified using default checkerboard pattern with one VDD everysize bumps in x-direction and one in two bumps in the y-direction
[INFO PSM-0031] Number of PDN nodes on net VPWR = 240.
[INFO PSM-0064] Number of voltage sources = 1
[INFO PSM-0040] All PDN stripes on net VPWR are connected.
[WARNING PSM-0016] Voltage pad location (vsrc) file not specified, defaulting pad location to checkerboard pattern on core area.
[WARNING PSM-0017] X direction bump pitch is not specified, defaulting to 140um.
[WARNING PSM-0018] Y direction bump pitch is not specified, defaulting to 140um.
[WARNING PSM-0019] Voltage on net VGND is not explicitly set.
[WARNING PSM-0021] Using voltage 0.000V for ground network.
[WARNING PSM-0063] Specified bump pitches of 140.000 and 140.000 are less than core width of 23.000 or core height of 32.640. Changing bump location to the center of the die at (11.500, 16.320)
[WARNING PSM-0065] VSRC location not specified using default checkerboard pattern with one VDD everysize bumps in x-direction and one in two bumps in the y-direction
[WARNING PSM-0030] Vsrc location at (11.500um, 16.320um) and size =10.000um, is not located on a power stripe. Moving to closest stripe at (10.800um, 21.682um).
[INFO PSM-0031] Number of PDN nodes on net VGND = 183.
[INFO PSM-0064] Number of voltage sources = 1
[INFO PSM-0040] All PDN stripes on net VGND are connected.

```

- Final Summary 

```

[INFO]: Calculating Runtime From the Start...
[INFO]: Flow completed for dvsd_pe/20-08_11-32 in 0h3m43s
[INFO]: Generating Final Summary Report...
[INFO]: Design Name: dvsd_pe
Run Directory: /openLANE_flow/designs/dvsd_pe/runs/20-08_11-32
----------------------------------------

Magic DRC Summary:
Source: /openLANE_flow/designs/dvsd_pe/runs/20-08_11-32/reports/magic//31-magic.drc
Total Magic DRC violations is 0
----------------------------------------

LVS Summary:
Source: /openLANE_flow/designs/dvsd_pe/runs/20-08_11-32/results/lvs/dvsd_pe.lvs_parsed.lef.log
LVS reports no net, device, pin, or property mismatches.
Total errors = 0
----------------------------------------

Antenna Summary:
Source: /openLANE_flow/designs/dvsd_pe/runs/20-08_11-32/reports/routing//33-antenna.rpt
Number of pins violated: 0
Number of nets violated: 0
[INFO]: check full report here: /openLANE_flow/designs/dvsd_pe/runs/20-08_11-32/reports/final_summary_report.csv
[INFO]: Saving Runtime Environment
[SUCCESS]: Flow Completed Without Fatal Errors.


```


### Final Layout

## Pre-layout

### Simulation

  Terminal snap (To perform pre-layout simulation)
  
  ![pre_layout_sim_ter](https://user-images.githubusercontent.com/80625515/130185638-d927ef90-81d7-4642-b03f-10dfdc7c3ce1.png)

  GTKWave output waveform
  
 ![pre_layout_sim](https://user-images.githubusercontent.com/80625515/130185662-662b9542-c5c1-4584-9d7f-da6d140f4aad.png)

### Steps to reproduce Pre-layout simulation

 Open terminal in your system (preferred Ubuntu OS)

```
git clone https://github.com/Khalique13/dvsd_pe_1v8.git
cd dvsd_pe_1v8/pre_layout/
iverilog -o dvsd_pe dvsd_pe.v test_dvsd_pe.v
./dvsd_pe
gtkwave dvsd_pe.vcd
```

### Performance

## Post-layout



### Simulation

Terminal snap (To perform post-layout simulation)

![post_lay_sim_term](https://user-images.githubusercontent.com/80625515/130189588-be201db3-9f21-4d12-9055-9806750a0675.png)

GTKWave output waveform

*`To be uploaded soon some bugs`*

### Steps to reproduce Post-layout simulation

 Open terminal in your system (preferred Ubuntu OS)

```
git clone https://github.com/Khalique13/dvsd_pe_1v8.git
cd dvsd_pe_1v8/post_layout/
iverilog -o gls gls.v primitives.v sky130_fd_sc_hd.v
./gls
gtkwave gls.vcd
```

## Instant count

## Steps to reproduce and explore the design

## Keys to remember

## Area of improvement

## References

- [GitLab/OpenLane workshop](https://gitlab.com/gab13c/openlane-workshop)
- [The OpenROAD Project/OpenLane](https://github.com/The-OpenROAD-Project/OpenLane)
- Ahmed Ghazy and Mohamed Shalan, "OpenLane: The Open-Source Digital ASIC Implementation Flow", Article No.21, Workshop on Open-Source EDA Technology (WOSET), 2020. [Paper](https://github.com/woset-workshop/woset-workshop.github.io/blob/master/PDFs/2020/a21.pdf)

## Acknowledgement

- [Kunal Ghosh](https://github.com/kunalg123), Founder, VSD Corp. Pvt. Ltd
- [Mohammad Khalique Khan](https://github.com/Khalique13), Bachelor of Technology in Electronics & Communication Engineering, Aliah University

