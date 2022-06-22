%% Response Time Analysis - Only for subj5 or later

genFolder = fullfile ('C:/Users/gabro/Documents/Graduate Studies/Research/FOK-Restudy Behavioural Study/FOK-Restudy Experimental Paradigm/SubjectData');
pFolder = fullfile (genFolder, 'subjmm47'); % Change according to who I'm analyzing
data = load (fullfile (pFolder, 'participantresults.txt'));

analysisfolder = fullfile ('C:/Users/gabro/Documents/Graduate Studies/Research/FOK-Restudy Behavioural Study/Data', 'subjmm47'); % change for person
if ~exist (analysisfolder)
    mkdir (analysisfolder);
end

%%

FOK1ResponseTime = 0;
FOK2ResponseTime = 0;
FOK3ResponseTime = 0;
FOK4ResponseTime = 0;
FOK5ResponseTime = 0;

FOK1TotalTime = 0;
FOK2TotalTime = 0;
FOK3TotalTime = 0;
FOK4TotalTime = 0;
FOK5TotalTime = 0;

FOK1Total = 0;
FOK2Total = 0;
FOK3Total = 0;
FOK4Total = 0;
FOK5Total = 0;

for i = 1:length(data)
    if data (i, 4) == 0
        if data (i, 5) == 1
            FOK1ResponseTime = FOK1ResponseTime + data (i, 7);
            FOK1TotalTime = FOK1TotalTime + data (i, 6);
            FOK1Total = FOK1Total + 1;
        end
        if data (i, 5) == 2
            FOK2ResponseTime = FOK2ResponseTime + data (i, 7);
            FOK2TotalTime = FOK2TotalTime + data (i, 6);
            FOK2Total = FOK2Total + 1;
        end
        if data (i, 5) == 3
            FOK3ResponseTime = FOK3ResponseTime + data (i, 7);
            FOK3TotalTime = FOK3TotalTime + data (i, 6);
            FOK3Total = FOK3Total + 1;
        end
        if data (i, 5) == 4
            FOK4ResponseTime = FOK4ResponseTime + data (i, 7);
            FOK4TotalTime = FOK4TotalTime + data (i, 6);
            FOK4Total = FOK4Total + 1;
        end
        if data (i, 5) == 5
            FOK5ResponseTime = FOK5ResponseTime + data (i, 7);
            FOK5TotalTime = FOK5TotalTime + data (i, 6);
            FOK5Total = FOK5Total + 1;
        end
    end
end

%% Average Times

FOK1ResponseTimeAverage = FOK1ResponseTime / FOK1Total;
FOK2ResponseTimeAverage = FOK2ResponseTime / FOK2Total;
FOK3ResponseTimeAverage = FOK3ResponseTime / FOK3Total;
FOK4ResponseTimeAverage = FOK4ResponseTime / FOK4Total;
FOK5ResponseTimeAverage = FOK5ResponseTime / FOK5Total;

FOK1TotalTimeAverage = FOK1TotalTime / FOK1Total;
FOK2TotalTimeAverage = FOK2TotalTime / FOK2Total;
FOK3TotalTimeAverage = FOK3TotalTime / FOK3Total;
FOK4TotalTimeAverage = FOK4TotalTime / FOK4Total;
FOK5TotalTimeAverage = FOK5TotalTime / FOK5Total;

%% Table, Save and Export

FOKTimes = zeros (1,10);
FOKTimes (1,1) = FOK1TotalTimeAverage;
FOKTimes (1,2) = FOK1ResponseTimeAverage;
FOKTimes (1,3) = FOK2TotalTimeAverage;
FOKTimes (1,4) = FOK2ResponseTimeAverage;
FOKTimes (1,5) = FOK3TotalTimeAverage;
FOKTimes (1,6) = FOK3ResponseTimeAverage;
FOKTimes (1,7) = FOK4TotalTimeAverage;
FOKTimes (1,8) = FOK4ResponseTimeAverage;
FOKTimes (1,9) = FOK5TotalTimeAverage;
FOKTimes (1,10) = FOK5ResponseTimeAverage;
            
arrayname = fullfile (analysisfolder, 'FOKTimes.txt');
dlmwrite (arrayname, FOKTimes);

FOKTimesTable = array2table (FOKTimes, 'VariableNames', {'FOK1MeanTotalTime', 'FOK1MeanFOKTime'...
    'FOK2MeanTotalTime', 'FOK2MeanFOKTime', 'FOK3MeanTotalTime', 'FOK3MeanFOKTime', 'FOK4MeanTotalTime', ...
    'FOK4MeanFOKTime', 'FOK5MeanTotalTime', 'FOK5MeanFOKTime'});
tablename = fullfile (analysisfolder, 'FOKTimesTable.xlsx');
writetable (FOKTimesTable, tablename);