% restudy vs RT

subjID = 'subjmm47'; % change
genFolder = fullfile...
    ('C:/Users/gabro/Documents/Graduate Studies/Research/FOK-Restudy Behavioural Study/FOK-Restudy Experimental Paradigm/SubjectData');
pFolder = fullfile (genFolder, subjID);
data = load (fullfile (pFolder, 'participantresults.txt'));

%% Average RT for Restudy vs non all trials

allrestudy = 0;
allnorestudy = 0;
allrestudyFOKRT = 0;
allnorestudyFOKRT = 0;

for i = 1:length(data)
    if data (i,8) == 1 % if it was restudied
        allrestudy = allrestudy + 1;
        allrestudyFOKRT = allrestudyFOKRT + data (i,6);
    elseif data (i,8) == 0
        allnorestudy = allnorestudy + 1;
        allnorestudyFOKRT = allnorestudyFOKRT + data (i,6);
    end
end

allrestudyFOKAVG = allrestudyFOKRT / allrestudy;
allnorestudyFOKAVG = allnorestudyFOKRT / allnorestudy;

%% Repeat for no success trials

restudy = 0;
norestudy = 0;
restudyFOKRT = 0;
norestudyFOKRT = 0;
restudyRT = 0;
norestudyRT = 0;

for i = 1:length(data)
    if data (i,4) == 0 % if it was unsuccessful
        if data (i,8) == 1 % if it was restudied
            restudy = restudy + 1;
            restudyFOKRT = restudyFOKRT + data (i,6);
        elseif data (i,8) == 0
            norestudy = norestudy + 1;
            norestudyFOKRT = norestudyFOKRT + data (i,6);
        end
    end
end

restudyFOKAVG = restudyFOKRT / restudy;
norestudyFOKAVG = norestudyFOKRT / norestudy;

%% Chart, Save and Export

RTnumbers = zeros (1,4);
RTnumbers (1,1) = allrestudyFOKAVG;
RTnumbers (1,2) = allnorestudyFOKAVG;
RTnumbers (1,3) = restudyFOKAVG;
RTnumbers (1,4) = norestudyFOKAVG;

%% Load Up Master File

masterdata = load...
    ('C:/Users/gabro/Documents/Graduate Studies/Research/FOK-Restudy Behavioural Study/Data/Compiled Results/Restudy Choices vs Response Times/RestudyvsRT.txt'); %import master data list

masterdata = [masterdata; RTnumbers]; % concactenate current matrix with master, replace master
filename = fullfile ...
    ('C:/Users/gabro/Documents/Graduate Studies/Research/FOK-Restudy Behavioural Study/Data/Compiled Results/Restudy Choices vs Response Times/RestudyvsRT.txt');
dlmwrite (filename, masterdata); % save new master in fill

masterdatatable = array2table (masterdata, 'VariableNames', {'AllRestudiedAverageFOKRT',...
    'AllNotRestudiedAverageFOKRT', 'NoSuccessRestudiedAverageFOKRT', ...
    'NoSuccessNotRestudiedAverageFOKRT'});
tablename = fullfile...
    ('C:/Users/gabro/Documents/Graduate Studies/Research/FOK-Restudy Behavioural Study/Data/Compiled Results/Restudy Choices vs Response Times/RestudyvsRTTable.xlsx');
writetable (masterdatatable, tablename); 