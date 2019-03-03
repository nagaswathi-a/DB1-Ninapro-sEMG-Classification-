tic
MC = 1;
for mc = 1:MC 
% [trainedClassifier, validationAccuracyFSD] = E2_FSDtrainClassifier(E2_FVTwin) % => 98.3%
% [trainedClassifier, validationAccuracyFSDTD] = E2_TDFSDtrainClassifier(E2_FVTwin) % => 99.01%
% [trainedClassifier, validationAccuracy] = E2_ARtrainClassifier(E2_FVTwin)

end
stoptime = toc;
