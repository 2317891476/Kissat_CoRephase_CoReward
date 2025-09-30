# Replication Instructions for Kissat_CoRephase_CoReward

## Prerequisites
Before you can replicate the results, ensure you have the following software installed:

- `7z` (for handling 7z compressed files)
- `drat-trim` (for proof trimming)
- `drabt` (for proof validation)
- `bash`

## Running Experiments

### 1. **Download the Dataset**

```shell
mkdir dataset
cd dataset
# Use wget to download datasets from the URIs listed in the specified file
wget --content-disposition -i ../scripts/track_main_2024.uri
```

### 2. Setup

The setup steps are already covered in the `README.md`. Please follow the instructions there to set up the environment and build the solver.

### 3. Run the Experiments

- To run all experiments, save the following script to the `script` directory and execute the script:

```bash
#!/bin/bash

# Define the directory containing the instances
INSTANCES_DIR="../dataset"

# Define the path to the solver executable
SOLVER_PATH="../src/Kissat_CoRephase_CoReward/build/kissat"

# Define the directory to store the results
RESULTS_DIR="../results"
mkdir -p $RESULTS_DIR

# Loop through all files in the instances directory
for instance in $INSTANCES_DIR/*.xz; do
    # Get the filename without the path
    filename=$(basename "$instance")
    
    # Define the output file path
    output_file="$RESULTS_DIR/${filename%.cnf}.txt"
    
    # Run the solver on the current instance and redirect the output to the output file
    echo "Running solver on $filename..."
    $SOLVER_PATH --time=5000 $instance > $output_file
done

echo "All instances processed."
```

- This script will run the solver on all instances in the `dataset` directory and save the results in the `results` directory.
- The entire dataset includes 400 instances, and some of these instances are very challenging to solve, even within a 5000-second time limit. Therefore, we recommend using the smaller dataset provided in the `instances` folder of the artifact for replication purposes. To do this, you should modify the `INSTANCES_DIR` variable to `INSTANCES_DIR="../instances"` in the script.

## Generating Plots

### 1. collect results

```bash
!/bin/bash

# Define the directory containing the results
RESULTS_DIR="../results"

# Define the output CSV file
OUTPUT_FILE="../data/results_summary.csv"

# Initialize the CSV file with headers
echo "Instance,Time(s),Arm1,Arm2,Arm3,Arm4" > $OUTPUT_FILE

# Loop through all files in the results directory
for result_file in $RESULTS_DIR/*.txt; do
    # Get the filename without the path
    filename=$(basename "$result_file")

    # Extract the instance name (without extension)
    instance=${filename%.txt}

    # Extract the time from the last 5th line of the result file
    line1=$(tail -n 5 "$result_file" | head -n 1 | sed 's/[[:space:]]\+/\ /g')
    time=$(echo "$line1" | awk '{print $(NF-1)}' | tr -d '[:space:]')

    # Extract the arm usage from the last 10th line of the result file
    line2=$(tail -n 10 "$result_file" | head -n 1 | sed 's/[[:space:]]\+/\ /g')
    arm_usage=$(echo "$line2" | awk '{print $(NF-3), $(NF-2), $(NF-1), $NF}')

    # Split the arm usage into individual variables
    IFS=' ' read -r -a arm_array <<< "$arm_usage"
    arm1=${arm_array[0]}
    arm2=${arm_array[1]}
    arm3=${arm_array[2]}
    arm4=${arm_array[3]}

    # Append the results to the CSV file
    echo "$instance,$time,$arm1,$arm2,$arm3,$arm4" >> $OUTPUT_FILE
done

echo "Results summary saved to $OUTPUT_FILE"
```

- This script reads the solving time and MAB arm usage from each result file in the `results` folder and writes the data to a CSV file located at `../data/results_summary.csv`.
- Ensure that the results folder contains all the necessary `.txt` files before running the script.
- **Use bash Interpreter**: Ensure that you run the scripts using the `bash` interpreter rather than `sh`. Some features used in these scripts, such as <<< , are specific to `bash` and may not work with `sh`.

### 2 Generate Plots Using Origin

- Use the provided scripts to aggregate the solving times for each solver across the entire dataset.
- Open the `results_summary.csv` file in a spreadsheet software. Copy the data and paste it into a new worksheet in `Origin`.
- In `Origin`, select the data columns you want to plot.
- Use the appropriate plot type (e.g., bar chart, line chart) to visualize the data.
- Customize the plot as needed (e.g., add labels, titles, legends).
- The `Origin` project file for this paper, `rephase.opju`, is provided.
- The satisfiability of instances can refer to: https://satcompetition.github.io/2023/downloads/sc2023-detailed-results.zip

## Important Notes

- **Use `bash` Interpreter**: Ensure that you run the scripts using the `bash` interpreter rather than `sh`. Some features used in these scripts, such as `<<<` (here-string), are specific to `bash` and may not work with `sh`.
- **Check File Paths**: Verify that the file paths in the scripts match the actual locations of your result files and output directories.

By following these steps, you can be able to successfully replicate the experimental results and generate the required plots using Origin software. If you have any questions or encounter any problems, please contact us at jmzhang@nudt.edu.cn.



