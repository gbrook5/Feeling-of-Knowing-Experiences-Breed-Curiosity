%% Data Analysis for behavioural results

subj = 'subjmm47';

genFolder = fullfile...
    ('C:\Users\gabro\Documents\Graduate Studies\Research\FOK-Restudy Behavioural Study\FOK-Restudy Experimental Paradigm\SubjectData');
pFolder = fullfile (genFolder, subj); % Change according to who I'm analyzing
data = load (fullfile (pFolder, 'participantresults.txt'));

%% Calculate Recall only RT (combined RT - FOKRT)

RT = data(:,6) - data(:,7);

%% Calculate SD

RTsd = std(RT);

%% Load Up Master File

masterdata = load...
    ('C:\Users\gabro\Documents\Graduate Studies\Research\FOK-Restudy Behavioural Study\Data\Compiled Results\Revisions\RevisionRTvariability.txt'); 
%import master data list

masterdata = [masterdata; RTsd]; % concactenate current matrix with master, replace master
filename = fullfile ...
    ('C:\Users\gabro\Documents\Graduate Studies\Research\FOK-Restudy Behavioural Study\Data\Compiled Results\Revisions\RevisionRTvariability.txt'); 
% save txt
dlmwrite (filename, masterdata); % save new master in fill

masterdatatable = array2table (masterdata, 'VariableNames', {'RTStandardDeviation'});
tablename = fullfile...
    ('C:\Users\gabro\Documents\Graduate Studies\Research\FOK-Restudy Behavioural Study\Data\Compiled Results\Revisions\RevisionRTvariability.xlsx'); 
% save table
writetable (masterdatatable, tablename); 
