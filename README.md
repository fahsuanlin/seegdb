# SEEGdb: SEEG database

Stereo-encephalography (SEEG) is the method to invasively record neuronal population activity via electrode implanation in medically refractory epilepsy patient. SEEG offers the unprecedented spatiotemporal resolution of neuronal activity recording. 

This project aims at providing a comprehensive accesss to SEEG data across all patients. Specifically, an interface linking between the electrode locations and data is created.

![](https://github.com/fahsuanlin/seegdb/blob/main/images/seeg_mne.png)

## Goal

1. Show all electrode contacts in a 3D brain model with adjustable surface transparency.

2. Find all electrode contacts withing a sphere of a specified radius. List all patient and electrode names and coordinates. Show these electrodes contacts in the brain model.

3. Create a way to insert, edit, delete electrode data. 

## Data

Here is the link to [a tar ball] of the electrode locations in the [MNI305](https://www.mcgill.ca/bic/software/tools-data-analysis/anatomical-mri/atlases/mni-305) coordinate system. Note that each patient had a few implanted electrodes, each of which had a few contacts. Patients were using electrodes from (AD-Tech](https://adtechmedical.com/epilepsy) with contacts separated by 5 mm. 

## Code
- To render a set of points (to represent a few electrode contacts) on the cortical surface in Matlab, you can use [our toolbox](https://github.com/fahsuanlin/fhlin_toolbox/wiki). With the installed toolbox, [this Matlab script]() shows a few electrods contact on the pial surface of the left hemisphere in the MNI305 atlas.

- Head model: Here are Matlab data files for the vertices and faces of the triangulated pial surface of the [left](https://github.com/fahsuanlin/seegdb/blob/master/data/brain_left.mat) and [right](https://github.com/fahsuanlin/seegdb/blob/master/data/brain_left.mat) hemispheres. The vertices are in millimeter. Note that the faces contain 0-based vertex indices.

- Coordinate system: X-, Y-, and Z-axes are illustrated in the figure below. 

## External resources.
- [SEEG electrode contact localization using post-op MRI](https://github.com/fahsuanlin/fhlin_toolbox/wiki/SEEG:-register-electrodes-to-MRI)
- [SEEG electrode contact localization using post-op MRI II](https://github.com/fahsuanlin/fhlin_toolbox/wiki/SEEG:-register-electrodes-to-MRI-(II))
