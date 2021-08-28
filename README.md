
[license](https://img.shields.io/github/license/Khalique13/dvsd_pe_sky130?color=red)



# 8 bit Priority Encoder (dvsd_pe_sky130) RTL2GDS flow using SKY130 pdks
*The purpose of this project is to produce a clean GDS (Graphic Design System) Final Layout with all details that are used to print photomasks used in the fabrication of a behavioral RTL (Register-Transfer Level) of an 8-bit Priority Encoder, using SkyWater 130 nm PDK (Process Design Kit)*

# Table of Contents

- [Design Overview](#design-overview)
- [IP specs Provided](#ip-specs-provided)
- [Verilog behavioral design](#verilog-behavioral-design)
- [Pre-layout](#pre-layout)
	- [Simulation](#simulation)
- [OpenLane](#openlane)
	- [Installation](#installation)
	- [Running OpenLane](#running-openlane)
- [Synthesis](#synthesis)
- [Floorplanning](#floorplanning)
- [Placement](#placement)
- [Routing](#routing)
- [Layout vs Schematic](#layout-vs-schematic)
- [Final Layout](#final-layout)
- [Post-layout](#post-layout)
	- [Simulation](#simulation)
- [Steps to reproduce and explore the design](#steps-to-reproduce-and-explore-the-design)
- [Key points to Remember](#key-points-to-remember)
- [Area of improvement](#area-of-improvement)
- [References](#references)
- [Acknowledgement](#acknowledgement)
- [Author](#author)



### Design Overview

![Slide2](https://user-images.githubusercontent.com/80625515/130179293-b7b03b4c-2feb-40a6-814a-31af06acc3cd.PNG)


### IP specs provided

![Slide4](https://user-images.githubusercontent.com/80625515/130180121-a4e5d529-bb6d-4ed3-a265-aad5030f82f7.PNG)

### Verilog behavioral design

Yosys synthesis

![synthesis_dot](https://user-images.githubusercontent.com/80625515/131134525-f122faa7-5f6e-4ab6-bb1e-593899d306a2.png)



## OpenLane 

OpenLane is an automated RTL to GDSII flow based on several components including OpenROAD, Yosys, Magic, Netgen, Fault and custom methodology scripts for design exploration and optimization.
For more information check [here](https://openlane.readthedocs.io/)

![openlane flow 1](https://user-images.githubusercontent.com/80625515/130246106-18f73ccc-e8e1-4061-a1b0-8c14bdf711f1.png)

### OpenLane design stages

1. Synthesis
	- `yosys` - Performs RTL synthesis
	- `abc` - Performs technology mapping
	- `OpenSTA` - Performs static timing analysis on the resulting netlist to generate timing reports
2. Floorplan and PDN
	- `init_fp` - Defines the core area for the macro as well as the rows (used for placement) and the tracks (used for routing)
	- `ioplacer` - Places the macro input and output ports
	- `pdn` - Generates the power distribution network
	- `tapcell` - Inserts welltap and decap cells in the floorplan
3. Placement
	- `RePLace` - Performs global placement
	- `Resizer` - Performs optional optimizations on the design
	- `OpenDP` - Perfroms detailed placement to legalize the globally placed components
4. CTS
	- `TritonCTS` - Synthesizes the clock distribution network (the clock tree)
5. Routing
	- `FastRoute` - Performs global routing to generate a guide file for the detailed router
	- `CU-GR` - Another option for performing global routing.
	- `TritonRoute` - Performs detailed routing
	- `SPEF-Extractor` - Performs SPEF extraction
6. GDSII Generation
	- `Magic` - Streams out the final GDSII layout file from the routed def
	- `Klayout` - Streams out the final GDSII layout file from the routed def as a back-up
7. Checks
	- `Magic` - Performs DRC Checks & Antenna Checks
	- `Klayout` - Performs DRC Checks
	- `Netgen` - Performs LVS Checks
	- `CVC` - Performs Circuit Validity Checks



### Installation

#### Prerequisites

- Preferred Ubuntu OS)
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

## Pre-layout

### Simulation

  Terminal snap (To perform pre-layout simulation)
  
  ![prelayterm](https://user-images.githubusercontent.com/80625515/131089636-fca42cd9-0f61-4710-8eb9-5d3847faac69.png)


  GTKWave output waveform
  
 ![pre_layout_sim](https://user-images.githubusercontent.com/80625515/130658528-78afca9c-b8ca-4344-91aa-acdd8d0521b3.png)


### Synthesis


![synth_explore](https://user-images.githubusercontent.com/80625515/130225635-8bee797c-dcf3-445f-9b02-b197dd2c3b39.png)

Synthesis reports

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

![synhesisstrategies](https://user-images.githubusercontent.com/80625515/131131994-32af7075-e086-429a-a7a6-276276c082fd.png)

![exploration-2](https://user-images.githubusercontent.com/80625515/131132250-3c9a5f4f-49c8-4453-b0b8-89275c041bb1.png)



### Floorplanning 


```

# User config
set ::env(DESIGN_NAME) dvsd_pe

# Change if needed
set ::env(VERILOG_FILES) [glob $::env(DESIGN_DIR)/src/*.v]

# turn off clock
set ::env(CLOCK_TREE_SYNTH) 0
set ::env(CLOCK_PORT) ""

set ::env(PL_SKIP_INITIAL_PLACEMENT) 1
set ::env(PL_RANDOM_GLB_PLACEMENT) 0

set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 34.165 54.885"
set ::env(PL_TARGET_DENSITY) 0.75

set ::env(FP_HORIZONTAL_HALO) 6
set ::env(FP_VERTICAL_HALO) $::env(FP_HORIZONTAL_HALO)

set filename $::env(DESIGN_DIR)/$::env(PDK)_$::env(STD_CELL_LIBRARY)_config.tcl
if { [file exists $filename] == 1} {
	source $filename
}

```



![floorplan_final](https://user-images.githubusercontent.com/80625515/130277419-7752eb72-0f37-482a-9ad6-5013479649a4.png)


### Placement

- Placement Analysis

```
---------------------------------
total displacement        274.2 u
average displacement        3.5 u
max displacement           33.8 u
original HPWL             639.8 u
legalized HPWL            838.1 u
delta HPWL                   31 %

```

- Routing resources analysis

```
          Routing      Original      Derated      Resource
Layer     Direction    Resources     Resources    Reduction (%)
---------------------------------------------------------------
li1        Vertical          420           396          5.71%
met1       Horizontal        560           380          32.14%
met2       Vertical          420           432          -2.86%
met3       Horizontal        280           234          16.43%
met4       Vertical          168           167          0.60%
met5       Horizontal         56            42          25.00%
---------------------------------------------------------------

```

- Final congestion report

```

Layer         Resource        Demand        Usage (%)    Max H / Max V / Total Overflow
---------------------------------------------------------------------------------------
li1                396            31            7.83%             0 /  0 /  0
met1               380            26            6.84%             0 /  0 /  0
met2               432             4            0.93%             0 /  0 /  0
met3               234             0            0.00%             0 /  0 /  0
met4               167             0            0.00%             0 /  0 /  0
met5                42             0            0.00%             0 /  0 /  0
---------------------------------------------------------------------------------------
Total             1651            61            3.69%             0 /  0 /  0

```

![placement_final](https://user-images.githubusercontent.com/80625515/130279072-c7e1e1dd-6061-46e0-a9d5-85c7470c8ebc.png)



### Routing



- Routing resurces analysis

```

          Routing      Original      Derated      Resource
Layer     Direction    Resources     Resources    Reduction (%)
---------------------------------------------------------------
li1        Vertical          420           168          60.00%
met1       Horizontal        560           384          31.43%
met2       Vertical          420           432          -2.86%
met3       Horizontal        280           234          16.43%
met4       Vertical          168           167          0.60%
met5       Horizontal         56            42          25.00%
---------------------------------------------------------------

```

- Final congestion report

```

Layer         Resource        Demand        Usage (%)    Max H / Max V / Total Overflow
---------------------------------------------------------------------------------------
li1                168            31           18.45%             0 /  0 /  0
met1               384            43           11.20%             0 /  0 /  0
met2               432            36            8.33%             0 /  0 /  0
met3               234             0            0.00%             0 /  0 /  0
met4               167             0            0.00%             0 /  0 /  0
met5                42             0            0.00%             0 /  0 /  0
---------------------------------------------------------------------------------------
Total             1427           110            7.71%             0 /  0 /  0

```

- Complete detail routing

```

total wire length = 874 um
total wire length on LAYER li1 = 62 um
total wire length on LAYER met1 = 341 um
total wire length on LAYER met2 = 438 um
total wire length on LAYER met3 = 31 um
total wire length on LAYER met4 = 0 um
total wire length on LAYER met5 = 0 um
total number of vias = 297
up-via summary (total 297):

----------------------
 FR_MASTERSLICE      0
            li1    153
           met1    138
           met2      6
           met3      0
           met4      0
----------------------
                   297

```

#### Final Summary 

```

Run Directory: /openLANE_flow/designs/dvsd_pe/runs/run
----------------------------------------

Magic DRC Summary:
Source: /openLANE_flow/designs/dvsd_pe/runs/run3/reports/magic//31-magic.drc
Total Magic DRC violations is 0
----------------------------------------

LVS Summary:
Source: /openLANE_flow/designs/dvsd_pe/runs/run3/results/lvs/dvsd_pe.lvs_parsed.lef.log
LVS reports no net, device, pin, or property mismatches.
Total errors = 0
----------------------------------------

Antenna Summary:
Source: /openLANE_flow/designs/dvsd_pe/runs/run3/reports/routing//33-antenna.rpt
Number of pins violated: 0
Number of nets violated: 0
[INFO]: check full report here: /openLANE_flow/designs/dvsd_pe/runs/run3/reports/final_summary_report.csv
[INFO]: Saving Runtime Environment
[SUCCESS]: Flow Completed Without Fatal Errors.

```

### Layout vs Schematic

- Subcircuit summary

```
Circuit 1: dvsd_pe                         |Circuit 2: dvsd_pe                         
-------------------------------------------|-------------------------------------------
sky130_fd_sc_hd__fill_2 (1)                |sky130_fd_sc_hd__fill_2 (1)                
sky130_fd_sc_hd__nand2_1 (1)               |sky130_fd_sc_hd__nand2_1 (1)               
sky130_fd_sc_hd__decap_4 (1)               |sky130_fd_sc_hd__decap_4 (1)               
sky130_fd_sc_hd__o21ai_1 (1)               |sky130_fd_sc_hd__o21ai_1 (1)               
sky130_fd_sc_hd__clkbuf_2 (5)              |sky130_fd_sc_hd__clkbuf_2 (5)              
sky130_fd_sc_hd__fill_1 (1)                |sky130_fd_sc_hd__fill_1 (1)                
sky130_fd_sc_hd__a21oi_1 (2)               |sky130_fd_sc_hd__a21oi_1 (2)               
sky130_fd_sc_hd__decap_8 (1)               |sky130_fd_sc_hd__decap_8 (1)               
sky130_fd_sc_hd__or4_1 (1)                 |sky130_fd_sc_hd__or4_1 (1)                 
sky130_fd_sc_hd__buf_1 (8)                 |sky130_fd_sc_hd__buf_1 (8)                 
sky130_fd_sc_hd__decap_6 (1)               |sky130_fd_sc_hd__decap_6 (1)               
sky130_fd_sc_hd__a2111o_1 (1)              |sky130_fd_sc_hd__a2111o_1 (1)              
sky130_fd_sc_hd__decap_3 (1)               |sky130_fd_sc_hd__decap_3 (1)               
sky130_fd_sc_hd__inv_2 (6)                 |sky130_fd_sc_hd__inv_2 (6)                 
sky130_fd_sc_hd__dlxtn_1 (3)               |sky130_fd_sc_hd__dlxtn_1 (3)               
sky130_fd_sc_hd__or2_1 (2)                 |sky130_fd_sc_hd__or2_1 (2)                 
sky130_fd_sc_hd__o2bb2a_1 (1)              |sky130_fd_sc_hd__o2bb2a_1 (1)              
sky130_fd_sc_hd__clkbuf_1 (4)              |sky130_fd_sc_hd__clkbuf_1 (4)              
sky130_fd_sc_hd__dlymetal6s2s_1 (1)        |sky130_fd_sc_hd__dlymetal6s2s_1 (1)        
sky130_fd_sc_hd__tapvpwrvgnd_1 (1)         |sky130_fd_sc_hd__tapvpwrvgnd_1 (1)         
sky130_fd_sc_hd__o22ai_1 (2)               |sky130_fd_sc_hd__o22ai_1 (2)               
sky130_fd_sc_hd__or3_1 (3)                 |sky130_fd_sc_hd__or3_1 (3)                 
sky130_fd_sc_hd__o41a_1 (2)                |sky130_fd_sc_hd__o41a_1 (2)                
sky130_fd_sc_hd__or3b_1 (1)                |sky130_fd_sc_hd__or3b_1 (1)                
sky130_fd_sc_hd__a2bb2o_1 (1)              |sky130_fd_sc_hd__a2bb2o_1 (1)              
sky130_fd_sc_hd__o22a_1 (1)                |sky130_fd_sc_hd__o22a_1 (1)                
sky130_fd_sc_hd__or4b_1 (1)                |sky130_fd_sc_hd__or4b_1 (1)                
Number of devices: 54                      |Number of devices: 54                      
Number of nets: 58                         |Number of nets: 58                         
---------------------------------------------------------------------------------------
Circuits match uniquely.
Netlists match uniquely.
```

- Subcircuits pins

```

Circuit 1: dvsd_pe                         |Circuit 2: dvsd_pe                         
-------------------------------------------|-------------------------------------------
in[0]                                      |in[0]                                      
in[1]                                      |in[1]                                      
in[2]                                      |in[2]                                      
in[5]                                      |in[5]                                      
in[4]                                      |in[4]                                      
in[3]                                      |in[3]                                      
en                                         |en                                         
in[6]                                      |in[6]                                      
in[7]                                      |in[7]                                      
eno                                        |eno                                        
out[2]                                     |out[2]                                     
out[0]                                     |out[0]                                     
out[1]                                     |out[1]                                     
gs                                         |gs                                         
VGND                                       |VGND                                       
VPWR                                       |VPWR                                       
---------------------------------------------------------------------------------------

```


### Final Layout

- Layout after floorplanning and placement in Magic

![placement](https://user-images.githubusercontent.com/80625515/130256581-da51bc37-2bde-4ffd-ad94-7078bfc02cab.png)

- Final GDS layout

![magic](https://user-images.githubusercontent.com/80625515/130256888-28aaf65e-121c-4939-8cdb-43f96f7c7625.png)

- Closeup view of the final layout design

![layoutwoplace](https://user-images.githubusercontent.com/80625515/130257192-88ad706d-0c44-4f5b-98c9-8a61a2c0f651.png)

- lef layout

![lef](https://user-images.githubusercontent.com/80625515/130257557-f2197c3f-4608-490e-adad-3b4878f7251c.png)

- tkcon window

![tkon](https://user-images.githubusercontent.com/80625515/130257765-e0b54334-3b84-4e30-ba94-704a7935440e.png)


## Post-layout

### Simulation

Terminal snap (To perform post-layout simulation)

![postlayterm](https://user-images.githubusercontent.com/80625515/131089729-e1d611c8-0685-495f-90ab-8409a3f8a9a7.png)


GTKWave output waveform

![postsynthwave](https://user-images.githubusercontent.com/80625515/130658574-daab2ac0-4300-4bf3-afec-a1a90778d29b.png)


## Steps to reproduce and explore the design

- Clone the project using following command
 
`git clone https://github.com/Khalique13/dvsd-8-bit-priority-encoder.git`

- To explore synthesis of the design

```
make mount
flow.tcl -design dvsd_pe -synth_explore
```

- To reproduce Pre-layout simulation

```
cd pre_layout/
iverilog -o dvsd_pe dvsd_pe.v test_dvsd_pe.v
./dvsd_pe
gtkwave dvsd_pe.vcd
```

- To explore floorplan

```
cd floorplan/
magic lef read merged.lef def read dvsd_pe.floorplan.def &
```

- To explore placement

```
cd placement/ 
magic lef read merged.lef def read dvsd_pe.placement.def &
```

- To explore final layout

```
cd final_layout/
magic dvsd_pe.mag
```

- To reproduce Post-layout simulation

```
cd post_layout/
iverilog -o gls -DFUNCTIONAL -DUNIT_DELAY=#1 gls.v primitives.v sky130_fd_sc_hd.v
./gls
gtkwave gls.vcd
```

- Complete details, logs and results can be found under this [folder](https://github.com/Khalique13/dvsd-8-bit-priority-encoder/tree/main/dvsd_pe). 

```
dvsd_pe
├── config.tcl
├── runs
│   ├── run
│   │   ├── config.tcl
│   │   ├── logs
│   │   │   ├── cts
│   │   │   ├── cvc
│   │   │   ├── floorplan
│   │   │   ├── klayout
│   │   │   ├── magic
│   │   │   ├── placement
│   │   │   ├── routing
│   │   │   └── synthesis
│   │   ├── reports
│   │   │   ├── cts
│   │   │   ├── cvc
│   │   │   ├── floorplan
│   │   │   ├── klayout
│   │   │   ├── magic
│   │   │   ├── placement
│   │   │   ├── routing
│   │   │   └── synthesis
│   │   ├── results
│   │   │   ├── cts
│   │   │   ├── cvc
│   │   │   ├── floorplan
│   │   │   ├── klayout
│   │   │   ├── magic
│   │   │   ├── placement
│   │   │   ├── routing
│   │   │   └── synthesis
│   │   └── tmp
│   │       ├── cts
│   │       ├── cvc
│   │       ├── floorplan
│   │       ├── klayout
│   │       ├── magic
│   │       ├── placement
│   │       ├── routing
│   │       └── synthesis
```

## Key points to Remember

- Keep the top module name and design name always, else errors would come in the design.
- This project is a Combinaional block hence there is no clock, static  time analysis is being skiped.

## Area of improvement

- Improvement in the design and integration of Power pins.
- To perform spice simulation of the final GDS layout.

## References

- [GitLab/OpenLane workshop](https://gitlab.com/gab13c/openlane-workshop)
- [The OpenROAD Project/OpenLane](https://github.com/The-OpenROAD-Project/OpenLane)
- Ahmed Ghazy and Mohamed Shalan, "OpenLane: The Open-Source Digital ASIC Implementation Flow", Article No.21, Workshop on Open-Source EDA Technology (WOSET), 2020. [Paper](https://github.com/woset-workshop/woset-workshop.github.io/blob/master/PDFs/2020/a21.pdf)

## Acknowledgement

- [Kunal Ghosh](https://github.com/kunalg123), Founder, VSD Corp. Pvt. Ltd

## Author

- [Mohammad Khalique Khan](https://github.com/Khalique13), Bachelor of Technology in Electronics & Communication Engineering, Aliah University

