%% 

subjID = 'subjmm47'; % change
genFolder = fullfile...
    ('C:/Users/gabro/Documents/Graduate Studies/Research/FOK-Restudy Behavioural Study/FOK-Restudy Experimental Paradigm/SubjectData');
pFolder = fullfile (genFolder, subjID);
data = load (fullfile (pFolder, 'participantresults.txt'));

%%

datanew = [];

for i =1:length(data)
    if data (i,4) == 0
        datanew = [datanew; data(i,:)];
    end
end 
        
[r, p] = corr(datanew(:,5),datanew(:,6), 'Type','Spearman');
if p <= 0.05
    sig = 1;
else 
    sig = 0;
end
corrs = [r p sig];


%% Load Up Master File

masterdata = load...
    ('C:/Users/gabro/Documents/Graduate Studies/Research/FOK-Restudy Behavioural Study/Data/Compiled Results/FOK vs Response Times/RTcorrelations_nosuccess.txt'); %import master data list

masterdata = [masterdata; corrs]; % concactenate current matrix with master, replace master
filename = fullfile ...
    ('C:/Users/gabro/Documents/Graduate Studies/Research/FOK-Restudy Behavioural Study/Data/Compiled Results/FOK vs Response Times/RTcorrelations_nosuccess.txt'); %import master data list
dlmwrite (filename, masterdata); % save new master in fill

masterdatatable = array2table (masterdata, 'VariableNames', {'r', 'p', 'Significance'});
tablename = fullfile...
    ('C:/Users/gabro/Documents/Graduate Studies/Research/FOK-Restudy Behavioural Study/Data/Compiled Results/FOK vs Response Times/RTcorrelationstable_nosuccess.xlsx'); %import master data list
writetable (masterdatatable, tablename);