![matlab version: R2019a](https://img.shields.io/badge/Matlab-R2019a-red)
![R version: 4.2.0](https://img.shields.io/badge/R-4.2.0-red)
[![DOI](https://zenodo.org/badge/502868293.svg)](https://zenodo.org/badge/latestdoi/502868293)



# SubMIC_Carvacrol

**SubMIC_Carvacrol:** A predictive microbiology framework to determine the effect of **Sub**inhibitory concentrations (working under the **M**inimal **I**nhibitory **C**oncentration) of **Carvacrol** on the foodborne bacterial species *Escherichia coli* and *Bacillus cereus*. The code in the repository provides experimental data and (model-based) estimated parameters to simulate the inactivation dynamics of *Escherichia coli* and *Bacillus cereus* viable counts (log scale of CFUs/mL) under different subinhibitory concentrations of **Carvarol** (mg/mL) during a time-lapse of 48 hours. The code integrates the mathematical model introduced in the article (soon to come) to explain the experimental data.

The repository **SubMIC_Carvacrol** contains the following subfolders:



**Simulations:**


Folder with the necessary files to run model-based simulations:

*- Carvacrol_Inhibition_of_Ecoli_Bcereus-Model&Data.m*: Script to run model-based simulations in the commercial computing software **MATLAB**.
*- Carvacrol_Inhibition_of_Ecoli_Bcereus-Model&Data.R*: Script to run model-based simulations in the free software for statistical computing **R**.


The simulation code has been kept simple so the user can introduce different parameter values and/or experimental data to simulate the model.



**Parameter_Estimation:**


Folder with the necessary files to perform the estimation of model parameters using the **MATLAB** optimisation toolbox **AMIGO2** (freely available at: https://sites.google.com/site/amigo2toolbox):

*- Run_PE.m:* Main script to run parameter estimation using **AMIGO2**. The user only needs to run the file *Run_PE.m* to perform the model calibration.

*- Model_SubMIC_Carvacrol.m:* Script to generate the mathematical model in **AMIGO2**.

*- PostProcess.m:* Script to plot and postprocesssing data.

*- Plot_ExpData.m:* Script to plot the experimental data.

*- Generated_data*: Folder with experimental data.

*- Generated_results*: Folder to save the estimation results and figures.




**Structural_Identifiability:**

Folder with the necessary code to perform a multi-experiment structural identifiability analysis of the mathematical model using the **MATLAB** toolbox **STRIKE-GOLDD** (freely available at: https://github.com/afvillaverde/strike-goldd).


*- z_create_Model_SubMIC_Carvacrol:* Script to generate the mathematical model in **STRIKE-GOLDD**.


*- options.m:* Script with **STRIKE-GOLDD** options setting the necessary configurations to perform the multi-experiment structural identifiability analysis of the mathematical model.


*- Model_SubMIC_Carvacrol.mat:* File containing the model data generated when run **z_create_Model_SubMIC_Carvacrol**.


To run the multi-experiment structural identifiability analysis, the user only needs to replace the default **options.m** file in **STRIKE-GOLDD** with the one provided in the repository and move the data file *Model_SubMIC_Carvacrol.mat* to the folder *models* of **STRIKE-GOLDD**. 


