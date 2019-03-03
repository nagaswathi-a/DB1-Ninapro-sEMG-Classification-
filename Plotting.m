% Computation speed or Elapsed Time for the feature set
% figure

c1 = categorical({'Exercise -a ' 'Exercise -b' 'Exercise -c' 'Total Exercises'});
y1 = [97.7, 98.3 ,97.9 ,96.7];

% c = categorical({'Time-Domain Feature-set','TD+Frequency-Domain Features','TD+FD+AR time-series Model'});
% y = [80.67 86.83 92 ];
barh(c1,y1,'stacked')
y = [2 2 3; 2 5 6; 2 8 9; 2 11 12];
bar(y,'stacked')
c = categorical({'apples','pears','oranges'});

 %plot(c,Accuracies) 
% bar(c,Accuracies,'FaceColor',[0,0.5,0.5],...
%        'EdgeColor',[0,0,0.9],...
%        'LineWidth',1)
% SVM Accuracy
% Performance of FSMAV feature in Classification