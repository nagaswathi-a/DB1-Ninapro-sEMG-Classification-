function [trainedClassifier, validationAccuracy] = E3_TDtrainClassifier(trainingData)
% [trainedClassifier, validationAccuracy] = trainClassifier(trainingData)
% returns a trained classifier and its accuracy. This code recreates the
% classification model trained in Classification Learner app. Use the
% generated code to automate training the same model with new data, or to
% learn how to programmatically train models.
%
%  Input:
%      trainingData: a table containing the same predictor and response
%       columns as imported into the app.
%
%  Output:
%      trainedClassifier: a struct containing the trained classifier. The
%       struct contains various fields with information about the trained
%       classifier.
%
%      trainedClassifier.predictFcn: a function to make predictions on new
%       data.
%
%      validationAccuracy: a double containing the accuracy in percent. In
%       the app, the History list displays this overall accuracy score for
%       each model.
%
% Use the code to train the model with new data. To retrain your
% classifier, call the function from the command line with your original
% data or new data as the input argument trainingData.
%
% For example, to retrain a classifier trained with the original data set
% T, enter:
%   [trainedClassifier, validationAccuracy] = trainClassifier(T)
%
% To make predictions with the returned 'trainedClassifier' on new data T2,
% use
%   yfit = trainedClassifier.predictFcn(T2)
%
% T2 must be a table containing at least the same predictor columns as used
% during training. For details, enter:
%   trainedClassifier.HowToPredict

% Auto-generated by MATLAB on 20-Dec-2018 15:26:38


% Extract predictors and response
% This code processes the data into the right shape for training the
% model.
inputTable = trainingData;
predictorNames = {'ar1_ch1', 'ar2_ch1', 'ar3_ch1', 'ar4_ch1', 'ar5_ch1', 'ar6_ch1', 'ar7_ch1', 'ar1_ch2', 'ar2_ch2', 'ar3_ch2', 'ar4_ch2', 'ar5_ch2', 'ar6_ch2', 'ar7_ch2', 'ar1_ch3', 'ar2_ch3', 'ar3_ch3', 'ar4_ch3', 'ar5_ch3', 'ar6_ch3', 'ar7_ch3', 'ar1_ch4', 'ar2_ch4', 'ar3_ch4', 'ar4_ch4', 'ar5_ch4', 'ar6_ch4', 'ar7_ch4', 'ar1_ch5', 'ar2_ch5', 'ar3_ch5', 'ar4_ch5', 'ar5_ch5', 'ar6_ch5', 'ar7_ch5', 'ar1_ch6', 'ar2_ch6', 'ar3_ch6', 'ar4_ch6', 'ar5_ch6', 'ar6_ch6', 'ar7_ch6', 'ar1_ch7', 'ar2_ch7', 'ar3_ch7', 'ar4_ch7', 'ar5_ch7', 'ar6_ch7', 'ar7_ch7', 'ar1_ch8', 'ar2_ch8', 'ar3_ch8', 'ar4_ch8', 'ar5_ch8', 'ar6_ch8', 'ar7_ch8', 'ar1_ch9', 'ar2_ch9', 'ar3_ch9', 'ar4_ch9', 'ar5_ch9', 'ar6_ch9', 'ar7_ch9', 'ar1_ch10', 'ar2_ch10', 'ar3_ch10', 'ar4_ch10', 'ar5_ch10', 'ar6_ch10', 'ar7_ch10', 'nar1_ch1', 'nar2_ch1', 'nar3_ch1', 'nar4_ch1', 'nar5_ch1', 'nar6_ch1', 'nar7_ch1', 'nar1_ch2', 'nar2_ch2', 'nar3_ch2', 'nar4_ch2', 'nar5_ch2', 'nar6_ch2', 'nar7_ch2', 'nar1_ch3', 'nar2_ch3', 'nar3_ch3', 'nar4_ch3', 'nar5_ch3', 'nar6_ch3', 'nar7_ch3', 'nar1_ch4', 'nar2_ch4', 'nar3_ch4', 'nar4_ch4', 'nar5_ch4', 'nar6_ch4', 'nar7_ch4', 'nar1_ch5', 'nar2_ch5', 'nar3_ch5', 'nar4_ch5', 'nar5_ch5', 'nar6_ch5', 'nar7_ch5', 'nar1_ch6', 'nar2_ch6', 'nar3_ch6', 'nar4_ch6', 'nar5_ch6', 'nar6_ch6', 'nar7_ch6', 'nar1_ch7', 'nar2_ch7', 'nar3_ch7', 'nar4_ch7', 'nar5_ch7', 'nar6_ch7', 'nar7_ch7', 'nar1_ch8', 'nar2_ch8', 'nar3_ch8', 'nar4_ch8', 'nar5_ch8', 'nar6_ch8', 'nar7_ch8', 'nar1_ch9', 'nar2_ch9', 'nar3_ch9', 'nar4_ch9', 'nar5_ch9', 'nar6_ch9', 'nar7_ch9', 'nar1_ch10', 'nar2_ch10', 'nar3_ch10', 'nar4_ch10', 'nar5_ch10', 'nar6_ch10', 'nar7_ch10', 'FM_ch1', 'FM_ch2', 'FM_ch3', 'FM_ch4', 'FM_ch5', 'FM_ch6', 'FM_ch7', 'FM_ch8', 'FM_ch9', 'FM_ch10', 'nFM_ch1', 'nFM_ch2', 'nFM_ch3', 'nFM_ch4', 'nFM_ch5', 'nFM_ch6', 'nFM_ch7', 'nFM_ch8', 'nFM_ch9', 'nFM_ch10', 'IAV_ch1', 'IAV_ch2', 'IAV_ch3', 'IAV_ch4', 'IAV_ch5', 'IAV_ch6', 'IAV_ch7', 'IAV_ch8', 'IAV_ch9', 'IAV_ch10', 'nIAV_ch1', 'nIAV_ch2', 'nIAV_ch3', 'nIAV_ch4', 'nIAV_ch5', 'nIAV_ch6', 'nIAV_ch7', 'nIAV_ch8', 'nIAV_ch9', 'nIAV_ch10', 'MAV_ch1', 'MAV_ch2', 'MAV_ch3', 'MAV_ch4', 'MAV_ch5', 'MAV_ch6', 'MAV_ch7', 'MAV_ch8', 'MAV_ch9', 'MAV_ch10', 'nMAV_ch1', 'nMAV_ch2', 'nMAV_ch3', 'nMAV_ch4', 'nMAV_ch5', 'nMAV_ch6', 'nMAV_ch7', 'nMAV_ch8', 'nMAV_ch9', 'nMAV_ch10', 'RMS_ch1', 'RMS_ch2', 'RMS_ch3', 'RMS_ch4', 'RMS_ch5', 'RMS_ch6', 'RMS_ch7', 'RMS_ch8', 'RMS_ch9', 'RMS_ch10', 'nRMS_ch1', 'nRMS_ch2', 'nRMS_ch3', 'nRMS_ch4', 'nRMS_ch5', 'nRMS_ch6', 'nRMS_ch7', 'nRMS_ch8', 'nRMS_ch9', 'nRMS_ch10', 'WL_ch1', 'WL_ch2', 'WL_ch3', 'WL_ch4', 'WL_ch5', 'WL_ch6', 'WL_ch7', 'WL_ch8', 'WL_ch9', 'WL_ch10', 'nWL_ch1', 'nWL_ch2', 'nWL_ch3', 'nWL_ch4', 'nWL_ch5', 'nWL_ch6', 'nWL_ch7', 'nWL_ch8', 'nWL_ch9', 'nWL_ch10'};
predictors = inputTable(:, predictorNames);
response = inputTable.C;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];

% Data transformation: Select subset of the features
% This code selects the same subset of features as were used in the app.
includedPredictorNames = predictors.Properties.VariableNames([false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true]);
predictors = predictors(:,includedPredictorNames);
isCategoricalPredictor = isCategoricalPredictor([false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true]);

% Train a classifier
% This code specifies all the classifier options and trains the classifier.
template = templateSVM(...
    'KernelFunction', 'gaussian', ...
    'PolynomialOrder', [], ...
    'KernelScale', 'auto', ...
    'BoxConstraint', 4.8, ...
    'Standardize', true);
classificationSVM = fitcecoc(...
    predictors, ...
    response, ...
    'Learners', template, ...
    'Coding', 'onevsone', ...
    'ClassNames', {'Class1'; 'Class10'; 'Class11'; 'Class12'; 'Class13'; 'Class14'; 'Class15'; 'Class16'; 'Class17'; 'Class18'; 'Class19'; 'Class2'; 'Class20'; 'Class21'; 'Class22'; 'Class23'; 'Class3'; 'Class4'; 'Class5'; 'Class6'; 'Class7'; 'Class8'; 'Class9'});

% Create the result struct with predict function
predictorExtractionFcn = @(t) t(:, predictorNames);
featureSelectionFcn = @(x) x(:,includedPredictorNames);
svmPredictFcn = @(x) predict(classificationSVM, x);
trainedClassifier.predictFcn = @(x) svmPredictFcn(featureSelectionFcn(predictorExtractionFcn(x)));

% Add additional fields to the result struct
trainedClassifier.RequiredVariables = {'ar1_ch1', 'ar2_ch1', 'ar3_ch1', 'ar4_ch1', 'ar5_ch1', 'ar6_ch1', 'ar7_ch1', 'ar1_ch2', 'ar2_ch2', 'ar3_ch2', 'ar4_ch2', 'ar5_ch2', 'ar6_ch2', 'ar7_ch2', 'ar1_ch3', 'ar2_ch3', 'ar3_ch3', 'ar4_ch3', 'ar5_ch3', 'ar6_ch3', 'ar7_ch3', 'ar1_ch4', 'ar2_ch4', 'ar3_ch4', 'ar4_ch4', 'ar5_ch4', 'ar6_ch4', 'ar7_ch4', 'ar1_ch5', 'ar2_ch5', 'ar3_ch5', 'ar4_ch5', 'ar5_ch5', 'ar6_ch5', 'ar7_ch5', 'ar1_ch6', 'ar2_ch6', 'ar3_ch6', 'ar4_ch6', 'ar5_ch6', 'ar6_ch6', 'ar7_ch6', 'ar1_ch7', 'ar2_ch7', 'ar3_ch7', 'ar4_ch7', 'ar5_ch7', 'ar6_ch7', 'ar7_ch7', 'ar1_ch8', 'ar2_ch8', 'ar3_ch8', 'ar4_ch8', 'ar5_ch8', 'ar6_ch8', 'ar7_ch8', 'ar1_ch9', 'ar2_ch9', 'ar3_ch9', 'ar4_ch9', 'ar5_ch9', 'ar6_ch9', 'ar7_ch9', 'ar1_ch10', 'ar2_ch10', 'ar3_ch10', 'ar4_ch10', 'ar5_ch10', 'ar6_ch10', 'ar7_ch10', 'nar1_ch1', 'nar2_ch1', 'nar3_ch1', 'nar4_ch1', 'nar5_ch1', 'nar6_ch1', 'nar7_ch1', 'nar1_ch2', 'nar2_ch2', 'nar3_ch2', 'nar4_ch2', 'nar5_ch2', 'nar6_ch2', 'nar7_ch2', 'nar1_ch3', 'nar2_ch3', 'nar3_ch3', 'nar4_ch3', 'nar5_ch3', 'nar6_ch3', 'nar7_ch3', 'nar1_ch4', 'nar2_ch4', 'nar3_ch4', 'nar4_ch4', 'nar5_ch4', 'nar6_ch4', 'nar7_ch4', 'nar1_ch5', 'nar2_ch5', 'nar3_ch5', 'nar4_ch5', 'nar5_ch5', 'nar6_ch5', 'nar7_ch5', 'nar1_ch6', 'nar2_ch6', 'nar3_ch6', 'nar4_ch6', 'nar5_ch6', 'nar6_ch6', 'nar7_ch6', 'nar1_ch7', 'nar2_ch7', 'nar3_ch7', 'nar4_ch7', 'nar5_ch7', 'nar6_ch7', 'nar7_ch7', 'nar1_ch8', 'nar2_ch8', 'nar3_ch8', 'nar4_ch8', 'nar5_ch8', 'nar6_ch8', 'nar7_ch8', 'nar1_ch9', 'nar2_ch9', 'nar3_ch9', 'nar4_ch9', 'nar5_ch9', 'nar6_ch9', 'nar7_ch9', 'nar1_ch10', 'nar2_ch10', 'nar3_ch10', 'nar4_ch10', 'nar5_ch10', 'nar6_ch10', 'nar7_ch10', 'FM_ch1', 'FM_ch2', 'FM_ch3', 'FM_ch4', 'FM_ch5', 'FM_ch6', 'FM_ch7', 'FM_ch8', 'FM_ch9', 'FM_ch10', 'nFM_ch1', 'nFM_ch2', 'nFM_ch3', 'nFM_ch4', 'nFM_ch5', 'nFM_ch6', 'nFM_ch7', 'nFM_ch8', 'nFM_ch9', 'nFM_ch10', 'IAV_ch1', 'IAV_ch2', 'IAV_ch3', 'IAV_ch4', 'IAV_ch5', 'IAV_ch6', 'IAV_ch7', 'IAV_ch8', 'IAV_ch9', 'IAV_ch10', 'nIAV_ch1', 'nIAV_ch2', 'nIAV_ch3', 'nIAV_ch4', 'nIAV_ch5', 'nIAV_ch6', 'nIAV_ch7', 'nIAV_ch8', 'nIAV_ch9', 'nIAV_ch10', 'MAV_ch1', 'MAV_ch2', 'MAV_ch3', 'MAV_ch4', 'MAV_ch5', 'MAV_ch6', 'MAV_ch7', 'MAV_ch8', 'MAV_ch9', 'MAV_ch10', 'nMAV_ch1', 'nMAV_ch2', 'nMAV_ch3', 'nMAV_ch4', 'nMAV_ch5', 'nMAV_ch6', 'nMAV_ch7', 'nMAV_ch8', 'nMAV_ch9', 'nMAV_ch10', 'RMS_ch1', 'RMS_ch2', 'RMS_ch3', 'RMS_ch4', 'RMS_ch5', 'RMS_ch6', 'RMS_ch7', 'RMS_ch8', 'RMS_ch9', 'RMS_ch10', 'nRMS_ch1', 'nRMS_ch2', 'nRMS_ch3', 'nRMS_ch4', 'nRMS_ch5', 'nRMS_ch6', 'nRMS_ch7', 'nRMS_ch8', 'nRMS_ch9', 'nRMS_ch10', 'WL_ch1', 'WL_ch2', 'WL_ch3', 'WL_ch4', 'WL_ch5', 'WL_ch6', 'WL_ch7', 'WL_ch8', 'WL_ch9', 'WL_ch10', 'nWL_ch1', 'nWL_ch2', 'nWL_ch3', 'nWL_ch4', 'nWL_ch5', 'nWL_ch6', 'nWL_ch7', 'nWL_ch8', 'nWL_ch9', 'nWL_ch10'};
trainedClassifier.ClassificationSVM = classificationSVM;
trainedClassifier.About = 'This struct is a trained model exported from Classification Learner R2018b.';
trainedClassifier.HowToPredict = sprintf('To make predictions on a new table, T, use: \n  yfit = c.predictFcn(T) \nreplacing ''c'' with the name of the variable that is this struct, e.g. ''trainedModel''. \n \nThe table, T, must contain the variables returned by: \n  c.RequiredVariables \nVariable formats (e.g. matrix/vector, datatype) must match the original training data. \nAdditional variables are ignored. \n \nFor more information, see <a href="matlab:helpview(fullfile(docroot, ''stats'', ''stats.map''), ''appclassification_exportmodeltoworkspace'')">How to predict using an exported model</a>.');

% Extract predictors and response
% This code processes the data into the right shape for training the
% model.
inputTable = trainingData;
predictorNames = {'ar1_ch1', 'ar2_ch1', 'ar3_ch1', 'ar4_ch1', 'ar5_ch1', 'ar6_ch1', 'ar7_ch1', 'ar1_ch2', 'ar2_ch2', 'ar3_ch2', 'ar4_ch2', 'ar5_ch2', 'ar6_ch2', 'ar7_ch2', 'ar1_ch3', 'ar2_ch3', 'ar3_ch3', 'ar4_ch3', 'ar5_ch3', 'ar6_ch3', 'ar7_ch3', 'ar1_ch4', 'ar2_ch4', 'ar3_ch4', 'ar4_ch4', 'ar5_ch4', 'ar6_ch4', 'ar7_ch4', 'ar1_ch5', 'ar2_ch5', 'ar3_ch5', 'ar4_ch5', 'ar5_ch5', 'ar6_ch5', 'ar7_ch5', 'ar1_ch6', 'ar2_ch6', 'ar3_ch6', 'ar4_ch6', 'ar5_ch6', 'ar6_ch6', 'ar7_ch6', 'ar1_ch7', 'ar2_ch7', 'ar3_ch7', 'ar4_ch7', 'ar5_ch7', 'ar6_ch7', 'ar7_ch7', 'ar1_ch8', 'ar2_ch8', 'ar3_ch8', 'ar4_ch8', 'ar5_ch8', 'ar6_ch8', 'ar7_ch8', 'ar1_ch9', 'ar2_ch9', 'ar3_ch9', 'ar4_ch9', 'ar5_ch9', 'ar6_ch9', 'ar7_ch9', 'ar1_ch10', 'ar2_ch10', 'ar3_ch10', 'ar4_ch10', 'ar5_ch10', 'ar6_ch10', 'ar7_ch10', 'nar1_ch1', 'nar2_ch1', 'nar3_ch1', 'nar4_ch1', 'nar5_ch1', 'nar6_ch1', 'nar7_ch1', 'nar1_ch2', 'nar2_ch2', 'nar3_ch2', 'nar4_ch2', 'nar5_ch2', 'nar6_ch2', 'nar7_ch2', 'nar1_ch3', 'nar2_ch3', 'nar3_ch3', 'nar4_ch3', 'nar5_ch3', 'nar6_ch3', 'nar7_ch3', 'nar1_ch4', 'nar2_ch4', 'nar3_ch4', 'nar4_ch4', 'nar5_ch4', 'nar6_ch4', 'nar7_ch4', 'nar1_ch5', 'nar2_ch5', 'nar3_ch5', 'nar4_ch5', 'nar5_ch5', 'nar6_ch5', 'nar7_ch5', 'nar1_ch6', 'nar2_ch6', 'nar3_ch6', 'nar4_ch6', 'nar5_ch6', 'nar6_ch6', 'nar7_ch6', 'nar1_ch7', 'nar2_ch7', 'nar3_ch7', 'nar4_ch7', 'nar5_ch7', 'nar6_ch7', 'nar7_ch7', 'nar1_ch8', 'nar2_ch8', 'nar3_ch8', 'nar4_ch8', 'nar5_ch8', 'nar6_ch8', 'nar7_ch8', 'nar1_ch9', 'nar2_ch9', 'nar3_ch9', 'nar4_ch9', 'nar5_ch9', 'nar6_ch9', 'nar7_ch9', 'nar1_ch10', 'nar2_ch10', 'nar3_ch10', 'nar4_ch10', 'nar5_ch10', 'nar6_ch10', 'nar7_ch10', 'FM_ch1', 'FM_ch2', 'FM_ch3', 'FM_ch4', 'FM_ch5', 'FM_ch6', 'FM_ch7', 'FM_ch8', 'FM_ch9', 'FM_ch10', 'nFM_ch1', 'nFM_ch2', 'nFM_ch3', 'nFM_ch4', 'nFM_ch5', 'nFM_ch6', 'nFM_ch7', 'nFM_ch8', 'nFM_ch9', 'nFM_ch10', 'IAV_ch1', 'IAV_ch2', 'IAV_ch3', 'IAV_ch4', 'IAV_ch5', 'IAV_ch6', 'IAV_ch7', 'IAV_ch8', 'IAV_ch9', 'IAV_ch10', 'nIAV_ch1', 'nIAV_ch2', 'nIAV_ch3', 'nIAV_ch4', 'nIAV_ch5', 'nIAV_ch6', 'nIAV_ch7', 'nIAV_ch8', 'nIAV_ch9', 'nIAV_ch10', 'MAV_ch1', 'MAV_ch2', 'MAV_ch3', 'MAV_ch4', 'MAV_ch5', 'MAV_ch6', 'MAV_ch7', 'MAV_ch8', 'MAV_ch9', 'MAV_ch10', 'nMAV_ch1', 'nMAV_ch2', 'nMAV_ch3', 'nMAV_ch4', 'nMAV_ch5', 'nMAV_ch6', 'nMAV_ch7', 'nMAV_ch8', 'nMAV_ch9', 'nMAV_ch10', 'RMS_ch1', 'RMS_ch2', 'RMS_ch3', 'RMS_ch4', 'RMS_ch5', 'RMS_ch6', 'RMS_ch7', 'RMS_ch8', 'RMS_ch9', 'RMS_ch10', 'nRMS_ch1', 'nRMS_ch2', 'nRMS_ch3', 'nRMS_ch4', 'nRMS_ch5', 'nRMS_ch6', 'nRMS_ch7', 'nRMS_ch8', 'nRMS_ch9', 'nRMS_ch10', 'WL_ch1', 'WL_ch2', 'WL_ch3', 'WL_ch4', 'WL_ch5', 'WL_ch6', 'WL_ch7', 'WL_ch8', 'WL_ch9', 'WL_ch10', 'nWL_ch1', 'nWL_ch2', 'nWL_ch3', 'nWL_ch4', 'nWL_ch5', 'nWL_ch6', 'nWL_ch7', 'nWL_ch8', 'nWL_ch9', 'nWL_ch10'};
predictors = inputTable(:, predictorNames);
response = inputTable.C;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];

% Perform cross-validation
partitionedModel = crossval(trainedClassifier.ClassificationSVM, 'KFold', 10);

% Compute validation predictions
[validationPredictions, validationScores] = kfoldPredict(partitionedModel);

% Compute validation accuracy
validationAccuracy = 1 - kfoldLoss(partitionedModel, 'LossFun', 'ClassifError');
