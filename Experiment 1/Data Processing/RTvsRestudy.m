%% - Seeing if RTs relate to restudy choices

% gamma stat for each participant between RT and restudy choice
% import, construct table, stat test

%% Import 

genFolder = fullfile ('C:/Users/gabro/Documents/Graduate Studies/Research/FOK-Restudy Behavioural Study/FOK-Restudy Experimental Paradigm/SubjectData');
pFolder = fullfile (genFolder, 'subjmm20'); % Change according to who I'm analyzing
data = load (fullfile (pFolder, 'participantresults.txt'));

%% Construct table

RTs = data (:,6);
restudies = data (:,8);

RTvsRestudies = [RTs restudies];

gkgammatst(RTvsRestudies, 0.05, 1);