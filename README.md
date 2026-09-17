# Bash Automated Pipeline

A Linux and Bash data pipeline that downloads country data from the REST Countries API, processes the downloaded JSON with Python and pandas, logs pipeline outcomes, summarizes successful and failed runs from the last 7 days, and runs automatically using cron.

## Project Overview

The main Bash script:

- Uses `curl` to download JSON data from the REST Countries API
- Checks whether the download succeeded
- Logs download success or failure with a timestamp
- Activates the project Python virtual environment
- Runs a Python processing script
- Checks whether the Python script succeeded
- Logs the number of records processed
- Writes detailed Python errors to a separate error log
- Removes the temporary JSON file when the script exits

A second Bash script reads the main log file and reports how many pipeline runs succeeded and failed during the last 7 days.

The pipeline is scheduled to run daily using cron.

## Project Structure

```text
bash-automated-pipeline/
├── run_pipeline.sh
├── summarize_runs.sh
├── process_country.py
├── requirements.txt
├── README.md
└── .gitignore

The following runtime files are generated locally and are excluded from Git:

data.json
log_file.txt
script_error.log
cron.log
venv/
Technologies Used
Linux
Bash
cron
curl
Python
pandas
Git
GitHub

Setup

Clone the repository:

git clone git@github.com:vuyo1996/bash-automated-pipeline.git
cd bash-automated-pipeline

Create a Python virtual environment:

python3 -m venv venv

Activate it:

source venv/bin/activate

Install the required Python packages:

pip install -r requirements.txt

Make the Bash scripts executable:

chmod u+x run_pipeline.sh
chmod u+x summarize_runs.sh
Running the Pipeline

Run the main pipeline:

./run_pipeline.sh

The script downloads the API response, processes it with Python, logs the result, and removes the temporary JSON file when complete.

View the pipeline log:

cat log_file.txt

Follow the log in real time:

tail -f log_file.txt
Run Summary

Run:

./summarize_runs.sh

Example output:

There were 7 successful runs.
There were 3 failed runs.

The script only counts pipeline outcomes recorded during the last 7 days.

Logging

log_file.txt stores the main pipeline history.

Example:

2026/09/16 15:51:05 Download successful.
2026/09/16 15:51:05 Script ran successfully. Records processed: 1.

If the Python processing script fails, the main log records the failure:

2026/09/16 15:50:12 Script failed to run. See /path/to/script_error.log for detailed logs.

Detailed Python output and tracebacks are stored in:

script_error.log

Cron output and errors can be redirected to:

cron.log
Cron Scheduling

The pipeline was first tested with a cron schedule that ran every minute.

After confirming that cron executed the script successfully, it was changed to run daily at 16:00.

Example crontab entry:

0 16 * * * /home/vuyo/DataEngineering/bash-automated-pipeline/run_pipeline.sh >> /home/vuyo/DataEngineering/bash-automated-pipeline/cron.log 2>&1

Edit the current user's crontab with:

crontab -e

Verify the saved cron job with:

crontab -l
Pipeline Flow
REST Countries API
        |
        v
      curl
        |
        v
    data.json
        |
        v
process_country.py
        |
        v
records processed
        |
        v
   log_file.txt

The Bash script controls the full workflow and checks the exit status of both the API download and the Python processing step.

Error Handling

The pipeline checks command exit codes after both major stages:

curl
Python processing

If the API download fails, the pipeline logs the failure and exits.

If the Python script fails, the pipeline logs the failure and writes the detailed Python error to script_error.log.

A Bash trap is used so that the temporary downloaded JSON file is removed when the pipeline exits.

What I Practised

This project was built to practise:

Bash scripting
Variables and command substitution
Functions
Exit codes
Conditional statements
File redirection
stdout and stderr
trap
curl
Python integration
Log processing
Cron scheduling
Git and GitHub workflow
