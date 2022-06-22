%% Response Time Analysis 

genFolder = fullfile ('C:/Users/gabro/Documents/Graduate Studies/Research/FOK-Restudy Behavioural Study/FOK-Restudy Experimental Paradigm/SubjectData');
pFolder = fullfile (genFolder, 'subjmm47'); % Change according to who I'm analyzing
data = load (fullfile (pFolder, 'participantresults.txt'));

analysisfolder = fullfile ('C:/Users/gabro/Documents/Graduate Studies/Research/FOK-Restudy Behavioural Study/Data', 'subjmm47'); % change for person
if ~exist (analysisfolder)
    mkdir (analysisfolder);
end

%%

FOKRT = zeros (0,2);

for i = 1:length(data)
    if data (i, 4) == 0
        info = [data(i,5) data(i,7)];
        FOKRT = [FOKRT; info];
    end
end

arrayname = fullfile (analysisfolder, 'FOKTRT_array.txt');
dlmwrite (arrayname, FOKRT);

FOKTimesTable = array2table (FOKRT, 'VariableNames', {'FOK', 'ResponseTime'});
tablename = fullfile (analysisfolder, 'FOKRT_table.xlsx');
writetable (FOKTimesTable, tablename);

[rho pval] = corr (FOKRT, 'Type', 'Spearman');
r = rho (1,2);
p = pval (1,2);
values = [r p];

rtable = load (fullfile('C://Users/gabro/Documents/Graduate Studies/Research/FOK-Restudy Behavioural Study/Analysis', 'rtable_FOKvsRT.txt'));
rtable = [rtable; values]; 
dlmwrite (fullfile('C://Users/gabro/Documents/Graduate Studies/Research/FOK-Restudy Behavioural Study/Analysis', 'rtable_FOKvsRT.txt'), rtable);

rtabletable = array2table (rtable, 'VariableNames', {'r', 'p'});
writetable(rtabletable, 'rtable_FOKvsRT.xlsx');

