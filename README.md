# DB1-Ninapro-sEMG-Classification-
According to Atzori et.al. [Atzori, Manfredo, et al. "Electromyography data for non-invasive naturally-controlled robotic hand prostheses." Scientific data 1 (2014): 140053], the first database contains data obtained from 27 intact subjects (20 males, 7 females; 25 right handed, 2 left handed; age 28 ± 3.4 years).  The first is the official Ninapro repository (Data Citation 1), which also gives the opportunity to upload classification results for each database, together with details regarding the classification procedure.  First database consisting of EMG 52 classes data which is divided based on into three types of exercises based
on movements.  It comprises (1) 12 basic movements of the fingers (2) 17 basic movements of the wrist and hand configurations (3) 23 grasping and functional movements having a total of \(C=52\) Categories. The data recorded using 10 Otto Bock sEMG Electrodes(gives rise to 10 channel vectors) with \(R=10\) movement repetitions. The EMG channels 1 to 8 contains the signal from the electrodes equally spaced around the forearm; channels 9 and 10 include the signal from the electrodes located on  muscle Flexor Digitorum Superficialis and of the  Extensor Digitorum Superficialis. Several signal processing steps were performed before making data publicly available on the repositories (Data Citations 1 and 2). These steps included synchronization, relabelling and (for the Delsys electrodes) filtering. The raw data are available upon successful registration at http://ninapro.hevs.ch/.

E1.m, E2.m, E3.m are the main codes consisting of step by step (section by section matlab code) for signal processing and feature extraction of EMG signals (obtained from the Ninapro-DB1): such as filtering, decomposition, denoising, statistical feature extraction on signal-window-segments, and concatenation of features to form a numerical feature vector in addition to the corresponding categorical column of class labels. Note that feature can be extracted with provided path to matlab functions such as 'getRMSfeat.m' uploaded in GitHub Master Branch; From each of three codes we obtain feature vector tables such as E1_FVTwin.mat; By concatenation of E1_FVTwin, E2_FVTwin and E3_FVTwin we obtain DB_FVT.mat 

Feature Vector Table with class labels: They are the processed matlab (.mat ) outputs for the EMG exercise E1,E2 and E3. DB is the Feature Vector of all exercises. It can be given as an input to the classifier. Normalized feature table (used in paper) available at the link https://drive.google.com/drive/folders/1C3VI72V0cmOQLFphGAwcToXrJrVP2kz8?usp=sharing and original feature vector table available at https://drive.google.com/drive/folders/1LDXkIR3aquQq_FqrQxMD-av5QWGmCRCf?usp=sharing .


To get the Classificatiom Results:
  
Select one trainClassifier matlab function file such as DB_trainClassifier provided here in GITHUB Master Branch and select one of the Feature vector table from E1_FVTwin, E2_FVTwin, E3_FVTwin and DB_FVTwin provided for download at above google drive link. 

SYNTAX as in Run_Execution.m file
tic;
MC = 1; 
for mc = 1:MC  
[trainedClassifier, validationAccuracy] = XYZ_trainClassifier(ABC_FVT) 
end
stoptime = toc;

After running the above mcode in matlab, validation accuracy can be observed for given classifier(such as Support Vector Machine SVM, Random Forest RF, KNN ) with a Feature vector Table of any exercise (E1:- 12 Class, E2:- 17Class, E3:- 23 Class or DB:- all 52 Classes). 
In the same master branch, also have provided the outputs of 'confusion matrices'(different image files and mat files) created under various classifiers functions. Thanks for reading :)
