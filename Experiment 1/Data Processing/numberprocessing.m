%% Computing some item numbers for fMRI contrasts

genFolder = fullfile ('C:/Users/gabro/Documents/Graduate Studies/Research/FOK-Restudy Behavioural Study/FOK-Restudy Experimental Paradigm/SubjectData');
pFolder = fullfile (genFolder, 'subjmm47'); % Change according to who I'm analyzing
data = load (fullfile (pFolder, 'participantresults.txt'));

analysisfolder = fullfile ('C:/Users/gabro/Documents/Graduate Studies/Research/FOK-Restudy Behavioural Study/Numbers', 'subjmm47'); % change for person
if ~exist (analysisfolder)
    mkdir (analysisfolder);
end

%% High FOK vs Low FOK, No Successful

highFOKtrials = 0;
lowFOKtrials = 0;

for i = 1:length(data)
    if data (i, 4) == 0
        if data (i, 5 ) == 4 || data(i,5) == 5
            highFOKtrials = highFOKtrials + 1;
        elseif data (i, 5 ) == 1 || data (i,5) == 2
            lowFOKtrials = lowFOKtrials + 1;
        end
    end
end

%% Restudy vs not

restudyselections = sum (data(:,8));
norestudyselections = length(data) - restudyselections;

%% High FOK restudy vs not, no successful

highFOKrestudy = 0;
highFOKnostudy = 0;

for i = 1:length(data)
    if data (i,4) == 0
        if data (i, 5) == 4 || data (i, 5) == 5
            if data (i, 8) == 1
                highFOKrestudy = highFOKrestudy + 1;
            elseif data (i,8) == 0
                highFOKnostudy = highFOKnostudy + 1;
            end
        end
    end
end

%% Low FOK restudy vs not
            
lowFOKrestudy = 0;
lowFOKnostudy = 0;

for i = 1:length(data)
    if data (i,4) == 0
        if data (i, 5) == 1 || data (i, 5) == 2
            if data (i, 8) == 1
                lowFOKrestudy = lowFOKrestudy + 1;
            elseif data (i,8) == 0
                lowFOKnostudy = lowFOKnostudy + 1;
            end
        end
    end
end            
            
%% Save numbers

numbers = zeros (1, 8);
numbers (1,1) = highFOKtrials;
numbers (1,2) = lowFOKtrials;
numbers (1,3) = restudyselections;
numbers (1,4) = norestudyselections;
numbers (1,5) = highFOKrestudy;
numbers (1,6) = highFOKnostudy;
numbers (1,7) = lowFOKrestudy;
numbers (1,8) = lowFOKnostudy;

arrayname = fullfile (analysisfolder, 'numbers.txt');
dlmwrite (arrayname, numbers);

numbertable = array2table (numbers, 'VariableNames', {'HighFOKTrialAmount', 'LowFOKTrialAmount', 'RestudySelections',...
    'NotRestudySelections', 'HighFOKTrialsRestudied', 'HighFOKTrialsNotRestudied', 'LowFOKTrialsRestudied',...
    'LowFOKTrialsNotRestudied'});
tablename = fullfile (analysisfolder, 'numbers.xlsx');
writetable (numbertable, tablename);
