# A Novel Incremental Learning Driven Instance Segmentation Framework to Recognize Highly Cluttered Instances of the Contraband Items
<p align="justify">
This repository contains the source code (developed using <b>TensorFlow 2.1.0</b> and <b>Keras 2.3.0</b>) for the proposed incremental instance segmentation framework.
</p>

![Block-Diagram](/images/BD.jpg) 
<p align="center"> Block Diagram of the Proposed Framework</p>

The documentation related to installation, configuration, dataset, training protocols is given below. Moroever, the detailed architectural description of the CIE-Net is available in 'model_summary.txt' file.

## Installation and Configuration
<p align="justify">
   
1) Platform: Anaconda and MATLAB R2020a (with deep learning, image processing and computer vision toolbox).
2) Install required packages from the provided ‘environment.yml’ file or alternatively you can install following packages yourself:
   - Python 3.7.9 or above
   - TensorFlow 2.1.0 or above 
   - Keras 2.3.0 or above
   - OpenCV 4.2 or above
   - imgaug 0.2.9 or above
   - tqdm   
3) Download the desired dataset:
   - GDXray [URL](https://domingomery.ing.puc.cl/material/gdxray/)
   - SIXray [URL](https://github.com/MeioJane/SIXray)
   - COCO-2017 [URL](https://cocodataset.org/#download)
4) Our mask-level annotations for the baggage X-ray datasets can be downloaded from the following links:
   - GDXray [URL]()
   - SIXray [URL]()

5) The box-level annotations for both baggage X-ray datasets are already released by the dataset authors. 

6) For COCO dataset, please use the MaskAPIs (provided by the dataset authors) to generate the mask-level and box-level annotations from the JSON files. We have also uploaded these APIs within this repository.

7) For training, please provide the training configurations of the desired dataset in ‘config.py’ file.

8) Afterward, create the two folders named as 'trainingDataset' and 'testingDataset', and arrange the dataset scans w.r.t the following hierarchy:

```
├── trainingDataset
│   ├── trainGT_1
│   │   └── tr_image_1.png
│   │   └── tr_image_2.png
│   │   ...
│   │   └── tr_image_n.png
│   ...
│   ├── trainGT_K
│   │   └── tr_image_1.png
│   │   └── tr_image_2.png
│   │   ...
│   │   └── tr_image_m.png
│   ├── trainImages_1
│   │   └── tr_image_1.png
│   │   └── tr_image_2.png
│   │   ...
│   │   └── tr_image_n.png
│   ...
│   ├── trainImages_K
│   │   └── tr_image_1.png
│   │   └── tr_image_2.png
│   │   ...
│   │   └── tr_image_m.png
│   ├── valGT_1
│   │   └── va_image_1.png
│   │   └── va_image_2.png
│   │   ...
│   │   └── va_image_o.png
│   ...
│   ├── valGT_K
│   │   └── va_image_1.png
│   │   └── va_image_2.png
│   │   ...
│   │   └── va_image_p.png
│   ├── valImages_1
│   │   └── va_image_1.png
│   │   └── va_image_2.png
│   │   ...
│   │   └── va_image_o.png
│   ...
│   ├── valImages_K
│   │   └── va_image_1.png
│   │   └── va_image_2.png
│   │   ...
│   │   └── va_image_p.png

├── testingDataset
│   ├── test_images
│   │   └── te_image_1.png
│   │   └── te_image_2.png
│   │   ...
│   │   └── te_image_k.png
│   ├── test_annotations
│   │   └── te_image_1.png
│   │   └── te_image_2.png
│   │   ...
│   │   └── te_image_k.png
│   ├── segmentation_results1
│   │   └── te_image_1.png
│   │   └── te_image_2.png
│   │   ...
│   │   └── te_image_k.png
│   ...
│   ├── segmentation_resultsK
│   │   └── te_image_1.png
│   │   └── te_image_2.png
│   │   ...
│   │   └── te_image_k.png
```
    - Note: the images and annotations should have same name and extension (preferably png).

9) The 'segmentation_resultsK' folder in 'testingDataset' will contains the results of K-instance-aware segmentation.
10) The summary of the proposed CIE-Net model is available in 'model_summary.txt'.
</p>

## Steps
<p align="justify">
   
1) Use 'trainer.py' to incrementally train the CIE-Net. The following script will also save the model instances in the h5 file. For MvRF-CNN, use 'trainer2.py' script.
2) Use 'tester.py' file to extract segmentation results for each model instance (the model results will be saved in 'segmentation_resultsk' folder for kth model instance).
3) We have also provided some converter scripts to convert e.g. original SIXray XML annotations into MATLAB structures, to port TF keras models into MATLAB etc.
4) Also, we have provided some utility files (in the 'utils' folder) to resize dataset scans, to generate bounding boxes from CIE-Net mask output, to change the coloring scheme of the CIE-Net outputs for better visualization, and to apply post-processing etc. 
5) Please note that to run MvRF-CNN, the images have to be resized to the resolution of 320x240x3. The resizer script is in the 'utils' folder.

</p>

## Citation
<p align="justify">
If you use the proposed incremental instance segmentation framework (or any part of this code) in your work, then please cite the following paper:
</p>

```
@article{cienet,
  title   = {A Novel Incremental Learning Driven Instance Segmentation Framework to Recognize Highly Cluttered Instances of the Contraband Items},
  author  = {Taimur Hassan and Samet Akcay and Mohammed Bennamoun and Salman Khan and Naoufel Werghi},
  journal = {Submitted in IEEE Transactions on Systems, Man, and Cybernetics: Systems},
  year = {2021}
}
```

## Contact
Please feel free to contact us in case of any query at: taimur.hassan@ku.ac.ae
