%% Does Priming Enhance Restudy - No success

% GARBAGE SCRIPT, SEE PROPORTION_CACULATE AND COMPILED TABLE FOR REAL/CORRECT DATA

genFolder = fullfile ('C:/Users/gabro/Documents/Graduate Studies/Research/FOK-Restudy Behavioural Study/FOK-Restudy Experimental Paradigm/SubjectData');
pFolder = fullfile (genFolder, 'subjmm47'); % Change according to who I'm analyzing
data = load (fullfile (pFolder, 'participantresults.txt'));

analysisfolder = fullfile ('C:/Users/gabro/Documents/Graduate Studies/Research/FOK-Restudy Behavioural Study/Data', 'subjmm47'); % change for person
if ~exist (analysisfolder)
    mkdir (analysisfolder);
end

primedrestudy = 0;
unprimedrestudy = 0;

for i = 1:length(data)
    if data (i, 4) == 0
        if data (i, 8) == 1
            if data(i,3) == 1
                primedrestudy = primedrestudy + 1;
            elseif data(i,3) == 0
                unprimedrestudy = unprimedrestudy + 1;
            end
        end
    end
end

proportionofprimedrestudied = primedrestudy / 26 * 100; % STUPID ME
proportionofunprimedrestudied = unprimedrestudy / 52 * 100; % STUPID ME

primingrestudies = zeros (1,2);
primingrestudies (1,1) = proportionofunprimedrestudied;
primingrestudies (1,2) = proportionofprimedrestudied;
%%
masterdata = importdata ('restudiedandpriming_nosuccess.txt');
masterdata = [masterdata; primingrestudies] ;
dlmwrite ('restudiedandpriming_nosuccess.txt', masterdata);

masterdatatable = array2table (masterdata, 'VariableNames', {'ProportionUnprimedRestudied', 'ProportionPrimedRestudied'});
writetable (masterdatatable, 'restudiedandpriming_nosuccess.xlsx');