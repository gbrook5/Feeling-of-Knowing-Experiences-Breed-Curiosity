%% Data Analysis for behavioural results

subj = 'subjmm47';

genFolder = fullfile...
    ('C:\Users\gabro\Documents\Graduate Studies\Research\FOK-Restudy Behavioural Study\FOK-Restudy Experimental Paradigm\SubjectData');
pFolder = fullfile (genFolder, subj); % Change according to who I'm analyzing
data = load (fullfile (pFolder, 'participantresults.txt'));

%% Calculate Recall only RT (combined RT - FOKRT)

RT = data(:,6) - data(:,7);

%% RT for restudied vs none, all trials

allrestudy = 0;
allnorestudy = 0;
allrestudyRT = 0;
allnorestudyRT = 0;

for i = 1:length(data)
    if data (i,8) == 1 % if it was restudied
        allrestudy = allrestudy + 1;
        allrestudyRT = allrestudyRT + RT(i);
    elseif data (i,8) == 0
        allnorestudy = allnorestudy + 1;
        allnorestudyRT = allnorestudyRT + RT(i);
    end
end

allrestudyRTavg = allrestudyRT / allrestudy;
allnorestudyRTavg = allnorestudyRT / allnorestudy;

%% Repeat for no success trials

restudy = 0;
norestudy = 0;
restudyRT = 0;
norestudyRT = 0;

for i = 1:length(data)
    if data(i, 4) == 0 % if it was also unsuccessful
        if data (i,8) == 1 % if it was restudied
            restudy = restudy + 1;
            restudyRT = restudyRT + RT(i);
        elseif data (i,8) == 0
            norestudy = norestudy + 1;
            norestudyRT = norestudyRT + RT(i);
        end
    end
end

nosuccessrestudyRTavg = restudyRT / restudy;
nosuccessnorestudyRTavg = norestudyRT / norestudy;

%% Chart

RTnumbers = zeros (1,4);
RTnumbers (1,1) = allrestudyRTavg;
RTnumbers (1,2) = allnorestudyRTavg;
RTnumbers (1,3) = nosuccessrestudyRTavg;
RTnumbers (1,4) = nosuccessnorestudyRTavg;

%% Load Up Master File

masterdata = load...
    ('C:\Users\gabro\Documents\Graduate Studies\Research\FOK-Restudy Behavioural Study\Data\Compiled Results\Revisions\RevisionRTanalyses.txt'); 
%import master data list

masterdata = [masterdata; RTnumbers]; % concactenate current matrix with master, replace master
filename = fullfile ...
    ('C:\Users\gabro\Documents\Graduate Studies\Research\FOK-Restudy Behavioural Study\Data\Compiled Results\Revisions\RevisionRTanalyses.txt'); 
% save txt
dlmwrite (filename, masterdata); % save new master in fill

masterdatatable = array2table (masterdata, 'VariableNames', {'AllRestudyRTAverage', ...
    'AllNoRestudyRTAverage', 'NoSuccessRestudyRTAverage', 'NoSuccessNoRestudyRTAverage'});
tablename = fullfile...
    ('C:\Users\gabro\Documents\Graduate Studies\Research\FOK-Restudy Behavioural Study\Data\Compiled Results\Revisions\RevisionRTanalyses.xlsx'); 
% save table
writetable (masterdatatable, tablename); 
