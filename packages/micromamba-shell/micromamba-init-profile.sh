#!/usr/bin/env bash

# Set up the required variables
export MAMBA_ROOT_PREFIX="${HOME}/micromamba"
export MAMBA_EXE=$(which micromamba)
export CONDA_EXE=$(which micromamba)

# Use conda as micromamba command
alias conda='micromamba'

# Initialize the shell
eval "$($MAMBA_EXE shell hook --shell=posix --root-prefix=$MAMBA_ROOT_PREFIX)"
