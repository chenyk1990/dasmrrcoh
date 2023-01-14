**DASmrrcoh**
======

## Description

**DASmrrcoh** package is used to store the reproducible and open-access scripts for denoising DAS data using MRR and enhancing earthquake detection by COHerency measure.

## Reference
If you find this package useful, please do not SAFODt to cite the following paper.

    Chen, Y., Savvaidis, A., Fomel, S., Chen, Y., Saad, O.M., (2023). Enhancing earthquake detection from distributed acoustic sensing data by coherency measure and moving-rank-reduction filtering, under review.
    
BibTeX:
	
	@article{dasmrrcoh,
	  author={Yangkang Chen and Alexandros Savvaidis and Yunfeng Chen and Omar M. Saad and Sergey Fomel},
	  title = {Enhancing earthquake detection from distributed acoustic sensing data by coherency measure and moving-rank-reduction filtering},
	  journal={TBD},
	  year=2023,
	  volume=X,
	  issue=X,
	  pages={under review},
	  doi={XXX},
	}

-----------
## Copyright
    Authors of the dasmrrcoh paper, 2021-present
-----------

## License
    GNU General Public License, Version 3
    (http://www.gnu.org/copyleft/gpl.html)   

-----------

## Install
Using the latest version

    git clone https://github.com/chenyk1990/dasmrrcoh
    cd dasmrrcoh
    addpath(genpath('./')); #in Matlab command line
    
-----------
## Examples
    The "main" directory contains all runable scripts test_figNO.m to reproduce all figures in the paper.
 
-----------
## Dependence Packages
* MATdrr (https://github.com/chenyk1990/MATdrr)
    
-----------
## Development
    The development team welcomes voluntary contributions from any open-source enthusiast. 
    If you want to make contribution to this project, feel free to contact the development team. 

-----------
## Contact
    Regarding any questions, bugs, developments, collaborations, please contact  
    Yangkang Chen
    chenyk2016@gmail.com

-----------
## NOTES:
 
1. To run the reproducible scripts (test_xxxx.m), please first download the required package from: https://github.com/chenyk1990/MATdrr. 

2. Please put the MATdrr package in the main directory and add its sub-directories to the Matlab toolbox path. 

3. The scripts beginning with "test_" are runnable scripts.

4. The directory subroutines stores all the required subroutines. 

5. The directory fig_bpsomffk stores all the results from the proposed denoising workflow.

6. The directory mat_raw stores all the segmented multi-channel DAS seismic data at the SAFOD site. 

7. The directory mat_bpsomffk stores all the denoised DAS data. 

8. The current version is based on Matlab. Future versions will also support Python and be optimized regarding computational efficiency. 

9. All datasets used in these DEMO scripts or produced from massive processing based on this package are in a separate repository https://github.com/chenyk1990/dasmrrcoh-dataonly (for easier downloading). 

10. test_oneevent.m is an example script to run through all processing steps (the three filters) for a specific event. It is used for denoising all the raw waveforms and produce the denoised waveforms. Both raw and denoised waveforms are stored in the repository of https://github.com/chenyk1990/dasmrrcoh-dataonly. 

11. The difference between the two "similar repositories" DASmrrcoh and dasmrrcoh-dataonly is that the latter is only used for storing the data (several GBs) and the former is only used for storing the scripts (less than 1 MB). 

12. All figures (except for fig1, which is a schematic plot) in the DASmrrcoh paper are in the following directory for a quick look (https://github.com/chenyk1990/dasmrrcoh-dataonly/tree/main/gallery/). 

-----------
## Gallery
The gallery figures of the DASmrrcoh package can be found at
    https://github.com/chenyk1990/dasmrrcoh-dataonly/tree/main/gallery/
Each figure in the gallery directory corresponds to a test_figNO.m script in the "main" directory with the exactly the same file name (figNO.png).

These gallery figures are also presented below. 

Figure 2
<img src='https://github.com/chenyk1990/gallery/blob/main/dasmrrcoh/fig2.png' alt='Slicing' width=960/>

Figure 3
<img src='https://github.com/chenyk1990/gallery/blob/main/dasmrrcoh/fig3.png' alt='Slicing' width=960/>

Figure 4
<img src='https://github.com/chenyk1990/gallery/blob/main/dasmrrcoh/fig4.png' alt='Slicing' width=960/>

Figure 5
<img src='https://github.com/chenyk1990/gallery/blob/main/dasmrrcoh/fig5.png' alt='Slicing' width=960/>

Figure 6
<img src='https://github.com/chenyk1990/gallery/blob/main/dasmrrcoh/fig6.png' alt='Slicing' width=960/>

Figure 7
<img src='https://github.com/chenyk1990/gallery/blob/main/dasmrrcoh/fig7.png' alt='Slicing' width=960/>

Figure 8
<img src='https://github.com/chenyk1990/gallery/blob/main/dasmrrcoh/fig8.png' alt='Slicing' width=960/>

Figure 9
<img src='https://github.com/chenyk1990/gallery/blob/main/dasmrrcoh/fig9.png' alt='Slicing' width=960/>

