%% Memory Accuracy for primed vs unprimed, no successful recall

genFolder = fullfile ('C:/Users/gabro/Documents/Graduate Studies/Thesis/FOK-Restudy Behavioural Study/FOK-Restudy Experimental Paradigm/SubjectData');
pFolder = fullfile (genFolder, 'subjmm47'); % Change according to who I'm analyzing
data = load (fullfile (pFolder, 'participantresults.txt'));

analysisfolder = fullfile ('C:/Users/gabro/Documents/Graduate Studies/Thesis/FOK-Restudy Behavioural Study/Data', 'subjmm47'); % change for person
if ~exist (analysisfolder)
    mkdir (analysisfolder);
end

%% Accuracy Chart

accuracy = data(:,9) == data (:, 10);

%% No Change in Forced Choice Accuracy for Primed Cues

primedcorrect = 0;
primedincorrect = 0;
unprimedcorrect = 0;
unprimedincorrect = 0;

for i = 1:length(accuracy)
    if data (i, 8) == 0 % if not restudied
        if accuracy (i) == 1
            if i <= 26
                primedcorrect = primedcorrect + 1;
            elseif i > 26
                unprimedcorrect = unprimedcorrect + 1;
            end
        elseif accuracy (i) == 0
            if i <= 26
                primedincorrect = primedincorrect + 1;
            elseif i > 26
                unprimedincorrect = unprimedincorrect + 1;
            end
        end
    end
end

primedaccuracy = primedcorrect / (primedcorrect + primedincorrect) * 100;
unprimedaccuracy = unprimedcorrect / (unprimedcorrect + unprimedincorrect) * 100;
overallaccuracy = (primedcorrect + unprimedcorrect) /(primedcorrect + primedincorrect + unprimedcorrect + unprimedincorrect) * 100;

primingaccuracies = zeros (1,2);
primingaccuracies (1,1) = unprimedaccuracy;
primingaccuracies (1,2) = primedaccuracy;

masterdata = importdata ('memoryaccuracyandpriming.txt');
masterdata = [masterdata; primingaccuracies] ;
dlmwrite ('memoryaccuracyandpriming.txt', masterdata);

masterdatatable = array2table (masterdata, 'VariableNames', {'AccuracyUnprimed', 'AccuracyPrimed'});
writetable (masterdatatable, 'memoryaccuracyandpriming.xlsx');