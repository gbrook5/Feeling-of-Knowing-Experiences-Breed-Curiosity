%% Response Time Analysis 

genFolder = fullfile ('C:/Users/gabro/Documents/Graduate Studies/Research/FOK-Restudy Behavioural Study/FOK-Restudy Experimental Paradigm/SubjectData');
pFolder = fullfile (genFolder, 'subjmm47'); % Change according to who I'm analyzing
data = load (fullfile (pFolder, 'participantresults.txt'));

analysisfolder = fullfile ('C:/Users/gabro/Documents/Graduate Studies/Research/FOK-Restudy Behavioural Study/Data', 'subjmm47'); % change for person
if ~exist (analysisfolder)
    mkdir (analysisfolder);
end

%%

RTprimed = 0;
RTunprimed = 0;
primed = 0;
unprimed = 0;

for i = 1:length(data)
    if data (i, 4) == 0
        if data (i, 3) == 0
            RTunprimed = RTunprimed + data (i,6);
            unprimed = unprimed + 1;
        elseif data (i,3) == 1
            RTprimed = RTprimed + data (i,6);
            primed = primed + 1;
        end
    end
end

RTprimedav = RTprimed / primed;
RTunprimedav = RTunprimed / unprimed;

RTaverage = [RTunprimedav RTprimedav];

masterdata = importdata ('RTpriming.txt');
masterdata = [masterdata; RTaverage];
dlmwrite ('RTpriming.txt', masterdata);

mastertable = array2table (masterdata, 'VariableNames', {'RTUnprimed', 'RTPrimed'});
writetable (mastertable, 'RTpriming.xlsx');
