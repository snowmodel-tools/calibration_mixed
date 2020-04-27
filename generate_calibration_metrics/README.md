### Notes for generating metrics from calibration runs
---
---
#### Ryan Crumley, April 2020; ryanlcrumley@gmail.com 
#### This workflow was developed and used for the Thompson Pass snowmodel simulations, 2018 - 2020.
---
---
This folder contains scripts to:
* Finding the SnowModel i,j pairs of a single grid cell within your domain (Observations of variable).

* Make a vector of values at that single grid location from the grads file (Modeled values of variable).

* Generate metrics based on the Modeled vs Observed values.

Pre-processing: I did some pre-processing work before I ran the first script below. I made a csv 
with the following columns:

*snotel_swe.csv*

* column1 = iterations from the snowmodel run
* column2 = snotel swe in meters
* column3 = alaska albers (m) value corresponding to the snotel Longitude
* column4 = alaska albers (m) value corresponding to the snotel Latitude

I made this csv manually by downloading the Snotel data, changing the column names, converting ft to m, and then I used QGIS to convert the Lat/Lon of the snotel station to alaska albers.

---
---

#### (Folder 01)
**find_sm_grid_cell.m**

This script uses the locations of point data and finds the corresponding grid cells in the SnowModel domain.

​	INPUTS: Preprocessed csv of snotel observations, additional parameters for the domain
​	OUTPUTS: A csv with the i,j pairs from the SnowModel domain 

---
---

#### (Folder 02)
**mk_vector_for_grid_location.m**

INPUTS: This script uses grid cell ij pair values and builds a vector of data from the snowmodel outputs. Again, since I only have one snotel station, I input the grid_i and grid_j values manually for lines 35 and 36.

* Place the script in each of the outputs/ folders for each model run because it has to access the .gdat output files.
* Edit the user input section.
* Use the previously generate snowmodel grid information in the grid_i and grid_j variables for line 35 & 36.

OUTPUTS: a .mat file with a vector of the data from the grid cell location. 

**mk_vector_for_grid_location.sh**

This script runs all of the *mk_vector_for_grid_location.m* files that are located in the subsequent directory system.
* Script opens, runs, and saves the mat files in the same folder location as the .gdat files.
* Script runs each one individually, and then moves on to the next folder. I usually place this in the highest level folder in the calibration folder structure so that it that will find all of the subsequent files. I usually only run this once per calibration.

---
---

#### (Folder 03)
**plot_vector_metrics.m**

NOTE: Make sure to uncomment the exit command on line 26 if you are running via the terminal. If you run on a local machine 
with Matlab displayed in a single folder, then leave it commented and it wont shut down Matlab. 

This script compares the values from the model grid cell vector (output from mk_vector_for_grid_location) and the snotel station
observed SWE record. 

~ On line 72 & 73 I take out two months, Aug and Sept, from the RMSE calculation for all years because snow is never found in
this part of the domain anyway during those months. But it definitely could be in October and sometimes early July. 

OUTPUTS: 1) Root Mean Squared Error value in a matlab table 2) Nash-Sutcliffe Efficiency value in a table 3) Kling-Gupta Efficiency 
value in a table 4) Mean Absolute Error value in a table 5) Index of Agreement value in a table 6) a plotted timeseries of the modeled and
observed data.

**plot_vector_metrics.sh**

This script runs all of the plot_vector_metrics.m files that are located in the subsequent directory system.

* Script opens, runs, and saves the matfile outputs in the same folder location as the .gdat files.
* Script runs each one individually, and then moves on to the next folder. I usually place this in the highest level folder in the calibration folder structure so that it that will find all of the subsequent files. I usually only run this once per calibration.

---
---

#### (Folder 04)
**table_builder.m**

INPUTS: Any number of stats table variables (stored in matfiles) from the previous plot_vector_metrics.m script.

The first thing I do is use the command line to find all of the mat files in the calibration folder structure with a command like this: 

```
$ find . -name '*.mat' -exec cp {} matfiles/ \;
```

This command says, find all the files ending in '.mat' and copy the results of the search to the matfiles/ folder located in the  current directory. Then, once you have all of the matfiles, add the table_builder.m script to the same folder.

This script aggregates and ranks each of the stats results from each model run and puts it into a ranked table. Remember: some of the rankings need to be sorted afterwards according to the type of metric. For example, for the RMSE metric, lower values are better so the ranking from lowest to highest works. But for the KGE metric, higher values are better and the ranking may need to be adjusted accordingly.

OUTPUTS: a ranked table of results from every model run in the calibration simulation, by metric.
