#!/bin/bash
dirs=($(find . -name 'wo_assim'))

for dir in "${dirs[@]}"; do
    (cd "$dir" && echo $PWD && matlab.2017b -nodisplay -nodesktop -nosplash -r mk_vector_for_grid_location)
done

