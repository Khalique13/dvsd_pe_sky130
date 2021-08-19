# dvsd_pe_1v8 (8 bit Priority Encoder RTL to GDS flow) 
In this project complete RTL to GDS flow has been done for 8 bit Priorty Encoder

# Contents
- Design Overview
- Verilog behavioral codes 
- Openlane
-- Installation
-- Adding a new design
-- Setting design configuration
-- Synthesis
-- Floorplan
-- Placement
-- Routing
-- Final Layout 
- RTL functional simulation results
- Pre-layout performance
- Instant count
- Post-layout Area
- Post-layout simulations (GLS)
-Steps to reproduce and explore the design

# OpenLane Output

All output run data is placed under ./designs/dvsd_pe/runs. Below is the flow structure that contains all the files including report, results, logs and tmp:
designs/dvsd_pe

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


