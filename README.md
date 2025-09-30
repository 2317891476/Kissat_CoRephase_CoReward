# Kissat_MAB_CoRephase Tool Artifact README

## 1 Introduction

This artifact contains the source code, build scripts, run scripts, and experimental data for the tool Kissat_CoRephase_CoReward described in our paper titled "Kissat_CoRephase_CoReward: Combining Different Rephasing Heuristics Using MAB in SAT". The tool combines various rephasing heuristics using Multi-Armed Bandits, and we demonstrate its effectiveness in solving Boolean satisfiability problems. 

## 2 Contents

- `LICENSE`: The license document for the artifact. 
- `README.md`: This file. 
- `src/`: Source code of the tool. 
- `scripts/`: Scripts for building and running the tool. The file `track_main_2024.uri` is also included in this folder.
- `instances/`：10 instances from the main track of the SAT competition 2024.
- `data/`: Experimental data used in the paper. 

## 3 Code

- Code Repository: https://github.com/2317891476/Kissat_CoRephase_CoReward.git

The code of Kissat_CoRephase_CoReward is also included in the `scripts/` folder.

### Baseline Solver

- Kissat_MAB: https://github.com/satcompetition/2021/blob/master/downloads/solvers-main.tar.xz
- Kissat_MAB-HyWalk: https://github.com/satcompetition/2022/blob/main/downloads/sequential-solvers.zip
- Kissat_MAB_Conflict+: https://github.com/satcompetition/2023/blob/main/downloads/Sequential.tar.xz
- Kissat-MAB-rephasing: https://github.com/satcompetition/2022/blob/main/downloads/sequential-solvers.zip

The code of these four solvers are also included in the `scripts/` folder.

## 4 Dataset Preparation

- Source: https://satcompetition.github.io/2024/downloads.html
- Dataset Download: Download the `track_main_2024.uri` file from the website, and execute the command `wget --content-disposition -i track_main_2024.uri` to download the dataset. The file `track_main_2024.uri` is also included in the `scripts/` folder.
- The benchmarks consist of 400 industrial instances from the main track of SAT Competition 2024. And the time limit for solving each instance is 5000 seconds, the same as that of the SAT Competition. In the `instances/` folder, we provide 10 instances to replicate a representative subset of results such that results can be reproduced on various hardware platforms in reasonable time. 

## 5 **System Requirements**

- **Operating System**: Linux (Ubuntu 20.04 or later is recommended)
- Dependencies:
  - `7z` (for handling 7z compressed files)
  - `drat-trim` (for proof trimming)
  - `drabt` (for proof validation)

## 6 Quick Start 
1. Unzip the artifact archive. 
2. Open a terminal and navigate to the unzipped directory. 
3. Run the following commands:

```bash
./scripts/setup.sh
./scripts/run.sh <INSTANCE_FILE>
# For example
./scripts/run.sh instances/1b86f59ce4c43f19f0ad1238f8c362b4-PRP_30_37.cnf.xz
```

## 7 Detailed Instructions 
### 7.1 Installation Steps

1. Install required packages

```bash
# Update package list and install required packages
sudo apt-get update
apt-get install p7zip-full
```

2. Install drat-trim

```bash
# Install drat-trim
cd env/drat-trim
make
```

3. Install drabt

```bash
cd env/drabt-004
make
```

4. Build the SAT solver

```bash
# Build the SAT solver
cd src/Kissat_MAB_CoRephase
make clean
./configure
make
```

### 7.2 Running SAT Solver

To run the SAT solver, you can use the following command:

```bash
# Run the solver with a 5000-second time limit
cd ./src/Kissat_MAB_CoRephase
./build/kissat --time=5000  <INSTANCE_FILE>
```

### 8 Replicating Results
- Follow the detailed instructions in `docs/replication_instructions.md` to replicate the results presented in the paper.  

