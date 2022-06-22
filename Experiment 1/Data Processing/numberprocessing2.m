%% Number Proccessing - Version 2

genFolder = fullfile ('C:/Users/gabro/Documents/Graduate Studies/Research/FOK-Restudy Behavioural Study/FOK-Restudy Experimental Paradigm/SubjectData');
pFolder = fullfile (genFolder, 'subjmm47'); % Change according to who I'm analyzing
data = load (fullfile (pFolder, 'participantresults.txt'));

analysisfolder = fullfile ('C:/Users/gabro/Documents/Graduate Studies/Research/FOK-Restudy Behavioural Study/Numbers', 'subjmm47'); % change for person
if ~exist (analysisfolder)
    mkdir (analysisfolder);
end

%% Process Overall FOK Numbers With Successful Trials

FOK1 = 0;
FOK2 = 0;
FOK3 = 0;
FOK4 = 0;
FOK5 = 0;

for i = 1:length(data)
    if data (i, 5) == 1
        FOK1 = FOK1 + 1;
    elseif data (i, 5) == 2
        FOK2 = FOK2 + 1;
    elseif data (i, 5) == 3
        FOK3 = FOK3 + 1;
    elseif data (i, 5) == 4
        FOK4 = FOK4 + 1;
    elseif data (i, 5) == 5
        FOK5 = FOK5 + 1;
    end
end

totalalltrials = FOK1 + FOK2 + FOK3 + FOK4 + FOK5;

%% FOK Numbers for No Successful Trials

FOK1No = 0;
FOK2No = 0;
FOK3No = 0;
FOK4No = 0;
FOK5No = 0;

for i = 1:length(data)
    if data (i, 4) == 0
        if data (i, 5 ) == 1
            FOK1No = FOK1No + 1;
        elseif data (i, 5) == 2
            FOK2No = FOK2No + 1;
        elseif data (i, 5) == 3
            FOK3No = FOK3No + 1;
        elseif data (i, 5) == 4
            FOK4No = FOK4No + 1;
        elseif data (i, 5) == 5
            FOK5No = FOK5No + 1;
        end
    end
end

NoSuccessTrials = FOK1No + FOK2No + FOK3No + FOK4No + FOK5No;
SuccessTrials = totalalltrials - NoSuccessTrials;

numbers =  zeros (1, 13);
numbers (1,1) = totalalltrials;
numbers (1,2) = FOK1;
numbers (1,3) = FOK2;
numbers (1,4) = FOK3;
numbers (1,5) = FOK4;
numbers (1,6) = FOK5;
numbers (1,7) = NoSuccessTrials;
numbers (1,8) = SuccessTrials;
numbers (1,9) = FOK1No;
numbers (1,10) = FOK2No;
numbers (1,11) = FOK3No;
numbers (1,12) = FOK4No;
numbers (1,13) = FOK5No;

arrayname = fullfile (analysisfolder, 'numbers2.txt');
dlmwrite (arrayname, numbers);

numbertable = array2table (numbers, 'VariableNames', {'TotalAllTrials', 'FOK1All', 'FOK2All', 'FOK3All',... 
    'FOK4All','FOK5All', 'NoSuccessfulRecallTrials', 'SuccessfulRecallTrials', 'FOK1NoSuccess',...
    'FOK2NoSuccess', 'FOK3NoSuccess', 'FOK4NoSuccess', 'FOK5NoSuccess'});
tablename = fullfile (analysisfolder, 'numbers2.xlsx');
writetable (numbertable, tablename); 