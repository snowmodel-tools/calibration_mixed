#!/bin/bash
dirs=($(find . -name 'wo_assim'))

for dir in "${dirs[@]}"; do
    (cd "$dir" && echo $PWD && matlab.2017b -nodisplay -nodesktop -nosplash -r plot_vector_metrics)
done
