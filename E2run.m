tic;
MC = 1;
for mc = 1:MC 
% [trainedClassifier, validationAccuracyFSD] = E2_FSDtrainClassifier(E2_FVTwin)
[trainedClassifier, validationAccuracyFSDTD] = E2_TDFSDtrainClassifier(E2_FVTwin)
end
stoptime = toc;
