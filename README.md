
![license](https://img.shields.io/github/license/Khalique13/dvsd_pe_sky130?color=red)



# 8 bit Priority Encoder (dvsd_pe_sky130) RTL2GDS flow using SKY130 pdks
*The purpose of this project is to produce a clean GDS (Graphic Design System) Final Layout with all details that are used to print photomasks used in the fabrication of a behavioral RTL (Register-Transfer Level) of an 8-bit Priority Encoder, using SkyWater 130 nm PDK (Process Design Kit).*

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
	- [Gate-Level-Simulation](#gate-level-simulation)
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

![synth-dot](https://user-images.githubusercontent.com/80625515/137538981-8c47acf3-2924-471b-a490-d757f6b1c51e.png)



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
$ sudo apt install -y git
$ git clone https://github.com/The-OpenROAD-Project/OpenLane.git
$ cd OpenLane/
$ make openlane
$ make pdk
$ make test # This a ~5 minute test that verifies that the flow and the pdk were properly installed
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
  
![prelayout-term](https://user-images.githubusercontent.com/80625515/137539586-98ffee2c-0806-431a-82b2-ce18dda56c18.png)


  GTKWave output waveform
  
![prelayout-waveform](https://user-images.githubusercontent.com/80625515/137539699-f4941ee3-48e7-414f-8600-f7684512c538.png)


### Synthesis

![synthesis](https://user-images.githubusercontent.com/80625515/137539959-22956191-d65b-4952-8b55-a5ed0d3a9648.png)


Synthesis reports

```

- Printing statistics.

=== dvsd_pe ===

   Number of wires:                 40
   Number of wire bits:             51
   Number of public wires:           5
   Number of public wire bits:      14
   Number of memories:               0
   Number of memory bits:            0
   Number of processes:              0
   Number of cells:                 42
     $_ANDNOT_                      14
     $_AND_                          1
     $_DLATCH_P_                     3
     $_NAND_                         3
     $_NOR_                          3
     $_ORNOT_                        6
     $_OR_                          12

```


``` 

- Printing statistics.

=== dvsd_pe ===

   Number of wires:                 18
   Number of wire bits:             27
   Number of public wires:           5
   Number of public wire bits:      14
   Number of memories:               0
   Number of memory bits:            0
   Number of processes:              0
   Number of cells:                 18
     sky130_fd_sc_hd__a21oi_2        1
     sky130_fd_sc_hd__a311o_2        1
     sky130_fd_sc_hd__a31o_2         1
     sky130_fd_sc_hd__and3_2         1
     sky130_fd_sc_hd__and4_2         1
     sky130_fd_sc_hd__buf_1          1
     sky130_fd_sc_hd__dlxtp_1        3
     sky130_fd_sc_hd__inv_2          6
     sky130_fd_sc_hd__o221ai_2       1
     sky130_fd_sc_hd__or2_2          1
     sky130_fd_sc_hd__or4_2          1

   Chip area for module '\dvsd_pe': 147.641600
```


- Yosys synthesis strategies

![synth-report](https://user-images.githubusercontent.com/80625515/137540786-c4dd26b4-2ef9-43ea-9274-90be2b33d81a.png)

![synthesis-comparison](https://user-images.githubusercontent.com/80625515/137540932-6fabcff6-9b9f-46e7-95e0-980f5ca02f2f.png)


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
set ::env(DIE_AREA) "0 0 50 50"
set ::env(PL_TARGET_DENSITY) 0.75

set ::env(FP_HORIZONTAL_HALO) 6
set ::env(FP_VERTICAL_HALO) $::env(FP_HORIZONTAL_HALO)

set filename $::env(DESIGN_DIR)/$::env(PDK)_$::env(STD_CELL_LIBRARY)_config.tcl
if { [file exists $filename] == 1} {
	source $filename
}
```

![floorplan](https://user-images.githubusercontent.com/80625515/137541026-efbb36b3-840d-4145-a439-9bb83b4ba23e.png)



### Placement

- Placement Analysis

```
total displacement          0.0 u
average displacement        0.0 u
max displacement            0.0 u
original HPWL             575.4 u
legalized HPWL            605.9 u
delta HPWL                    5 %
```

- Routing resources analysis

```
          Routing      Original      Derated      Resource
Layer     Direction    Resources     Resources    Reduction (%)
---------------------------------------------------------------
li1        Vertical          735           622          15.37%
met1       Horizontal        980           746          23.88%
met2       Vertical          735           642          12.65%
met3       Horizontal        490           426          13.06%
met4       Vertical          294           250          14.97%
met5       Horizontal         98            78          20.41%
---------------------------------------------------------------

```

- Final congestion report

```


Layer         Resource        Demand        Usage (%)    Max H / Max V / Total Overflow
---------------------------------------------------------------------------------------
li1                622            40            6.43%             0 /  0 /  0
met1               746            33            4.42%             0 /  0 /  0
met2               642             0            0.00%             0 /  0 /  0
met3               426             0            0.00%             0 /  0 /  0
met4               250             0            0.00%             0 /  0 /  0
met5                78             0            0.00%             0 /  0 /  0
---------------------------------------------------------------------------------------
Total             2764            73            2.64%             0 /  0 /  0

```
![placement](https://user-images.githubusercontent.com/80625515/137541779-850ffb8e-bdc8-468e-9562-ffc79f143900.png)



### Routing



- Routing resurces analysis

```

          Routing      Original      Derated      Resource
Layer     Direction    Resources     Resources    Reduction (%)
---------------------------------------------------------------
li1        Vertical          735           100          86.39%
met1       Horizontal        980           746          23.88%
met2       Vertical          735           642          12.65%
met3       Horizontal        490           426          13.06%
met4       Vertical          294           250          14.97%
met5       Horizontal         98            78          20.41%
---------------------------------------------------------------

```

- Final congestion report

```
Layer         Resource        Demand        Usage (%)    Max H / Max V / Total Overflow
---------------------------------------------------------------------------------------
li1                100             1            1.00%             0 /  0 /  0
met1               746            34            4.56%             0 /  0 /  0
met2               642            39            6.07%             0 /  0 /  0
met3               426             0            0.00%             0 /  0 /  0
met4               250             0            0.00%             0 /  0 /  0
met5                78             0            0.00%             0 /  0 /  0
---------------------------------------------------------------------------------------
Total             2242            74            3.30%             0 /  0 /  0

```

- Complete detail routing

```
Total wire length = 563 um.
Total wire length on LAYER li1 = 0 um.
Total wire length on LAYER met1 = 253 um.
Total wire length on LAYER met2 = 290 um.
Total wire length on LAYER met3 = 20 um.
Total wire length on LAYER met4 = 0 um.
Total wire length on LAYER met5 = 0 um.
Total number of vias = 182.
Up-via summary (total 182):.

----------------------
 FR_MASTERSLICE      0
            li1     89
           met1     89
           met2      4
           met3      0
           met4      0
----------------------
                   182


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
sky130_fd_sc_hd__decap_12 (1)              |sky130_fd_sc_hd__decap_12 (1)              
sky130_fd_sc_hd__decap_8 (1)               |sky130_fd_sc_hd__decap_8 (1)               
sky130_fd_sc_hd__fill_2 (1)                |sky130_fd_sc_hd__fill_2 (1)                
sky130_fd_sc_hd__decap_4 (1)               |sky130_fd_sc_hd__decap_4 (1)               
sky130_fd_sc_hd__decap_6 (1)               |sky130_fd_sc_hd__decap_6 (1)               
sky130_fd_sc_hd__fill_1 (1)                |sky130_fd_sc_hd__fill_1 (1)                
sky130_fd_sc_hd__clkbuf_2 (5)              |sky130_fd_sc_hd__clkbuf_2 (5)              
sky130_fd_sc_hd__dlxtp_1 (3)               |sky130_fd_sc_hd__dlxtp_1 (3)               
sky130_fd_sc_hd__inv_2 (6)                 |sky130_fd_sc_hd__inv_2 (6)                 
sky130_fd_sc_hd__decap_3 (1)               |sky130_fd_sc_hd__decap_3 (1)               
sky130_fd_sc_hd__a41o_1 (1)                |sky130_fd_sc_hd__a41o_1 (1)                
sky130_fd_sc_hd__and4_1 (1)                |sky130_fd_sc_hd__and4_1 (1)                
sky130_fd_sc_hd__nor2_1 (1)                |sky130_fd_sc_hd__nor2_1 (1)                
sky130_fd_sc_hd__a311o_1 (1)               |sky130_fd_sc_hd__a311o_1 (1)               
sky130_fd_sc_hd__or2_1 (1)                 |sky130_fd_sc_hd__or2_1 (1)                 
sky130_fd_sc_hd__buf_1 (7)                 |sky130_fd_sc_hd__buf_1 (7)                 
sky130_fd_sc_hd__clkbuf_1 (3)              |sky130_fd_sc_hd__clkbuf_1 (3)              
sky130_fd_sc_hd__tapvpwrvgnd_1 (1)         |sky130_fd_sc_hd__tapvpwrvgnd_1 (1)         
sky130_fd_sc_hd__o221ai_1 (1)              |sky130_fd_sc_hd__o221ai_1 (1)              
sky130_fd_sc_hd__a21oi_1 (1)               |sky130_fd_sc_hd__a21oi_1 (1)               
sky130_fd_sc_hd__or4_1 (1)                 |sky130_fd_sc_hd__or4_1 (1)                 
Number of devices: 40                      |Number of devices: 40                      
Number of nets: 43                         |Number of nets: 43                         
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

- lef layout

![lef-layout](https://user-images.githubusercontent.com/80625515/137545042-064206ce-cc52-46f8-b45a-bda1be66c8bf.png)


- Magic layout

![magic-layout](https://user-images.githubusercontent.com/80625515/137545100-b16ef838-4e84-486d-9d07-d57bfbc732b1.png)


- tkcon window

![magic-tkcon](https://user-images.githubusercontent.com/80625515/137545197-8d774152-4c4d-4e00-9c5c-1848af8ea843.png)


- Klayout GDS

![klayoutgds](https://user-images.githubusercontent.com/80625515/137545303-62a291ff-1d84-4b6a-abae-d98ffd6f2e12.png)


- Klayout XOR check

![klayout-xor](https://user-images.githubusercontent.com/80625515/137545345-2aa5b2b7-4dc0-470f-bce8-217eb0e6a284.png)


## Post-layout

### Gate-Level-Simulation

Terminal snap (To perform post-layout simulation)

![gls-term](https://user-images.githubusercontent.com/80625515/137545692-5d76bbbf-0b27-45f3-a52a-9215bf763b3d.png)


GTKWave output waveform

![gate-level-simulation-result](https://user-images.githubusercontent.com/80625515/137545918-538d588e-61fc-479c-9ddc-0a8529a78cc8.png)



## Steps to reproduce and explore the design

- Clone the project using following command
 
```
$ git clone https://github.com/Khalique13/dvsd_pe_sky130.git
```


- To explore Pre-layout simulation

```
$ cd pre_layout/
$ gtkwave dvsd_pe.vcd
```

- To explore floorplan

```
$ cd floorplan/
$ magic lef read merged.lef def read dvsd_pe.floorplan.def &
```

- To explore placement

```
$ cd placement/ 
$ magic lef read merged.lef def read dvsd_pe.placement.def &
```

- To explore final layout

```
# to view Magic layout
$ cd layout_magic/
$ magic dvsd_pe.mag

# to view GDS view using Klayout
$ cd layout_klayout/
$ klayout dvsd_pe.gds 
```

- To explore Post-layout (Gate Level Simulation)

```
$ cd post_layout/
$ gtkwave gls.vcd
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

## References

- [GitLab/OpenLane workshop](https://gitlab.com/gab13c/openlane-workshop)
- [The OpenROAD Project/OpenLane](https://github.com/The-OpenROAD-Project/OpenLane)
- Ahmed Ghazy and Mohamed Shalan, "OpenLane: The Open-Source Digital ASIC Implementation Flow", Article No.21, Workshop on Open-Source EDA Technology (WOSET), 2020. [Paper](https://github.com/woset-workshop/woset-workshop.github.io/blob/master/PDFs/2020/a21.pdf)

## Acknowledgement

[Kunal Ghosh](https://github.com/kunalg123), Founder, VSD Corp. Pvt. Ltd
- Contact: kunalpghosh@gmail.com

## Author

[Mohammad Khalique Khan](https://github.com/Khalique13)
- Contact: gjkhalique@gmail.com 

