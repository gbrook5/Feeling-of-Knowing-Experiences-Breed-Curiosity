% Data Analysis for behavioural results

genFolder = fullfile ('C:/Users/gabro/Documents/Graduate Studies/Research/FOK-Restudy Behavioural Study/FOK-Restudy Experimental Paradigm/SubjectData');
pFolder = fullfile (genFolder, 'subjmm47'); % Change according to who I'm analyzing
data = load (fullfile (pFolder, 'participantresults.txt'));

analysisfolder = fullfile ('C:/Users/gabro/Documents/Graduate Studies/Research/FOK-Restudy Behavioural Study/Data', 'subjmm47'); % change for person
if ~exist (analysisfolder)
    mkdir (analysisfolder);
end

%% Enhanced FOK for Primed Cues

FOKprimed = mean (data (1:26, 5));
FOKunprimed = mean (data (27:end, 5));

%% Accuracy Chart

accuracy = data(:,9) == data (:, 10);

%% No Change in Forced Choice Accuracy for Primed Cues

primedcorrect = 0;
unprimedcorrect = 0;

for i = 1:length(accuracy)
    if accuracy (i) == 1
        if i <= 26
            primedcorrect = primedcorrect + 1;
        elseif i > 26
            unprimedcorrect = unprimedcorrect + 1;
        end
    end
end

primedaccuracy = primedcorrect / 26 * 100;
unprimedaccuracy = unprimedcorrect / 52 * 100;
overallaccuracy = (sum(accuracy)) /78 * 100;

%% Restudy Improves Performance

restudycorrect = 0;
nostudycorrect = 0;

for i = 1:length(accuracy)
    if accuracy (i) == 1
        if data (i,8) == 1
            restudycorrect = restudycorrect + 1;
        elseif data (i, 8) == 0
            nostudycorrect = nostudycorrect + 1;
        end
    end
end

restudyaccuracy = restudycorrect / (sum(data(:,8))) * 100;
nostudyaccuracy = nostudycorrect / (78 - sum(data(:,8))) * 100;

%% Does Priming Enhance Restudy

primedrestudy = 0;
unprimedrestudy = 0;

for i = 1:length(data)
    if data (i, 8) == 1
        if i <= 26 
            primedrestudy = primedrestudy + 1;
        elseif i > 26
            unprimedrestudy = unprimedrestudy + 1;
        end
    end
end

proportionofprimedrestudied = primedrestudy / 26 * 100;
proportionofunprimedrestudied = unprimedrestudy / 52 * 100;

proportionrestudyprimed = primedrestudy / (sum(data(:,8))) * 100;
proportionrestudyunprimed = unprimedrestudy / (sum(data(:,8))) * 100;

%% FOK Correlate with Restudy

highFOK = 0;
lowFOK = 0;
highFOKrestudy = 0;
lowFOKrestudy = 0;

for i = 1:length(data)
    if data (i, 5 ) == 4 || data(i,5) == 5
        highFOK = highFOK + 1;
        if data (i,8) == 1
            highFOKrestudy = highFOKrestudy + 1;
        end
    elseif data (i, 5 ) == 1 || data (i,5) == 2
        lowFOK = lowFOK + 1;
        if data (i, 8) == 1
            lowFOKrestudy = lowFOKrestudy + 1;
        end
    end
end

highFOKrestudyproportion = highFOKrestudy / highFOK * 100;
lowFOKrestudyproportion = lowFOKrestudy / lowFOK * 100;

%% FOK Correlate with Restudy, Ignore if Recall Successful

highFOKnosuccess = 0;
lowFOKnosuccess = 0;
highFOKrestudynosuccess = 0;
lowFOKrestudynosuccess = 0;

for i = 1:length(data)
    if data (i, 4) == 0
        if data (i, 5 ) == 4 || data(i,5) == 5
            highFOKnosuccess = highFOKnosuccess + 1;
            if data (i,8) == 1
                highFOKrestudynosuccess = highFOKrestudynosuccess + 1;
            end
        elseif data (i, 5 ) == 1 || data (i,5) == 2
            lowFOKnosuccess = lowFOKnosuccess + 1;
            if data (i, 8) == 1
                lowFOKrestudynosuccess = lowFOKrestudynosuccess + 1;
            end
        end
    end
end

norecallhighFOKrestudyproportion = highFOKrestudynosuccess / highFOKnosuccess * 100;
norecalllowFOKrestudyproportion = lowFOKrestudynosuccess / lowFOKnosuccess * 100;

%% Rstudy proportion with FOK (post-success correction)

restudyproportionhighFOK = highFOKrestudynosuccess / (sum(data(:,8))) * 100;
restudyproportionlowFOK = lowFOKrestudynosuccess / (sum(data(:,8))) * 100;

%% Do people restudy primed high FOK more than unprimed high FOK

primedhighFOK = 0;
unprimedhighFOK = 0;
primedhighFOKrestudy = 0;
unprimedhighFOKrestudy = 0;

for i = 1:length (data)
    if data (i,4) == 0
        if data (i, 5) == 4 || data (i, 5) == 5
            if data (i,3) == 1
                primedhighFOK = primedhighFOK + 1;
                if data (i,8) == 1
                    primedhighFOKrestudy = primedhighFOKrestudy + 1;
                end
            elseif data (i,3) == 0
                unprimedhighFOK = unprimedhighFOK + 1;
                if data (i, 8) == 1
                    unprimedhighFOKrestudy = unprimedhighFOKrestudy + 1;
                end
            end
        end
    end
end
               
highFOKrestudyprimed = primedhighFOKrestudy / primedhighFOK * 100;
highFOKretudyunprimed = unprimedhighFOKrestudy / unprimedhighFOK * 100;

%% Accuracy of "Successful Recall" vs High FOK

successrecallcorrect = 0;
successrecallwrong = 0;

for i = 1:length(data)
    if data (i, 4) == 1
        if accuracy (i) == 1
            successrecallcorrect = successrecallcorrect + 1;
        elseif accuracy (i) == 0
            successrecallwrong = successrecallwrong + 1;
        end
    end
end

successfulrecallaccuracy = successrecallcorrect / (successrecallcorrect + successrecallwrong) * 100;

%% Save Results

processeddata = zeros (1, 19);
processeddata (1,1) = FOKunprimed;
processeddata (1,2) = FOKprimed;
processeddata (1,3) = unprimedaccuracy;
processeddata (1,4) = primedaccuracy;
processeddata (1,5) = restudyaccuracy;
processeddata (1,6) = nostudyaccuracy;
processeddata (1,7) = highFOKrestudyproportion;
processeddata (1,8) = lowFOKrestudyproportion;
processeddata (1,9) = norecallhighFOKrestudyproportion;
processeddata (1,10) = norecalllowFOKrestudyproportion;
processeddata (1,11) = restudyproportionhighFOK;
processeddata (1,12) = restudyproportionlowFOK;
processeddata (1,13) = proportionofunprimedrestudied;
processeddata (1,14) = proportionofprimedrestudied;
processeddata (1,15) = proportionrestudyunprimed;
processeddata (1,16) = proportionrestudyprimed;
processeddata (1,17) = highFOKrestudyprimed;
processeddata (1,18) = highFOKretudyunprimed; 
processeddata (1,19) = successfulrecallaccuracy;

arrayname = fullfile (analysisfolder, 'processeddata.txt');
dlmwrite (arrayname, processeddata);

processeddatatable = array2table (processeddata, 'VariableNames', {'UnprimedFOK', 'PrimedFOK',...
    'UnprimedMemoryAccuracy', 'PrimedMemoryAccuracy', 'AccuracyOfRestudied','AccuracyOfNotRestudied',...
    'ProportionOfFOK4or5HighRestudied', 'ProportionOfFOK1or2LowRestudied', 'RestudyHighFOKNoSuccessfulRecall', ...
    'RestudyLowFOKNoSuccessfulRecall', 'ProportionOfRestudyHighFOKNoSuccess', 'ProportionOfRestudyLowFOKNoSuccess', ...
    'ProportionOfUnprimedRestudied', 'ProportionOfPrimedRestudied', 'ProportionOfRestudyUnprimed',...
    'ProportionOfRestudyPrimed', 'ProportionOfPrimedHighFOKRestudied', 'ProportionOfUnprimedHighFOKrestudied',...
    'AccuracyOfSuccessfulRecallTrials'});
tablename = fullfile (analysisfolder, 'processeddata.xlsx');
writetable (processeddatatable, tablename);

%% Accuracy for each non-restudied vs FOK

veryhighFOKnorestudy = 0;
highFOKnorestudy = 0;
neutralFOKnorestudy = 0;
lowFOKnorestudy =0;
verylowFOKnorestudy = 0;

veryhighFOKcorrect = 0;
highFOKcorrect = 0;
neutralFOKcorrect = 0;
lowFOKcorrect = 0;
verylowFOKcorrect = 0;

for i = 1:length(data)
    if data (i, 8) == 0
        if data (i, 5) == 5
            veryhighFOKnorestudy = veryhighFOKnorestudy + 1;
            if accuracy (i) == 1
                veryhighFOKcorrect = veryhighFOKcorrect + 1;
            end
        elseif data (i, 5) == 4
            highFOKnorestudy = highFOKnorestudy + 1;
            if accuracy (i) == 1
                highFOKcorrect = highFOKcorrect + 1;
            end
        elseif data (i, 5) == 3
            neutralFOKnorestudy = neutralFOKnorestudy + 1;
            if accuracy (i) == 1
                neutralFOKcorrect = neutralFOKcorrect + 1;
            end
        elseif data (i, 5) == 2
            lowFOKnorestudy = lowFOKnorestudy + 1;
            if accuracy (i) == 1
                lowFOKcorrect = lowFOKcorrect + 1;
            end
        elseif data (i, 5) == 1
            verylowFOKnorestudy = verylowFOKnorestudy + 1;
            if accuracy (i) == 1
                verylowFOKcorrect = verylowFOKcorrect + 1;
            end
        end
    end
end

FOKaccuracies = zeros (1,5);
FOKaccuracies (1,5) = veryhighFOKcorrect / veryhighFOKnorestudy * 100;
FOKaccuracies (1,4) = highFOKcorrect / highFOKnorestudy * 100;
FOKaccuracies (1,3) = neutralFOKcorrect / neutralFOKnorestudy * 100;
FOKaccuracies (1,2) = lowFOKcorrect / lowFOKnorestudy * 100;
FOKaccuracies (1,1) = verylowFOKcorrect / verylowFOKnorestudy * 100;
            
arrayname = fullfile (analysisfolder, 'FOKaccuraciesnonrestudied.txt');
dlmwrite (arrayname, FOKaccuracies);

FOKdatatable = array2table (FOKaccuracies, 'VariableNames', {'FOKRating1Accuracy', 'FOKRating2Accuracy'...
    'FOKRating3Accuracy', 'FOKRating4Accuracy', 'FOKRating5Accuracy'});
tablename = fullfile (analysisfolder, 'FOKaccuraciesnonrestudied.xlsx');
writetable (FOKdatatable, tablename);    