# Note: please modify these parameters as per your application need and/or dataset. 
# number of iterations 
K = 2 # to identify at most two instances of the same item within the single scan
folderPath = "testingDataset/test_images/"
resultsPath = "testingDataset/segmentation_results"
# By default, we are adding 5 classes in first iteration, and 5 more classes in 2nd iteration (total: 10). Modify these settings as per your choice.
newClasses = [5, 5] 
imgHeight = 576 #240
imgWidth = 768 #320