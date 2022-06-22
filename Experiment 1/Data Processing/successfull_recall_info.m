%% Restudy selections for "successful recall trials"

genFolder = fullfile ('C:/Users/gabro/Documents/Graduate Studies/Research/FOK-Restudy Behavioural Study/FOK-Restudy Experimental Paradigm/SubjectData');
pFolder = fullfile (genFolder, 'subjmm47'); % Change according to who I'm analyzing
data = load (fullfile (pFolder, 'participantresults.txt'));

analysisfolder = fullfile ('C:/Users/gabro/Documents/Graduate Studies/Research/FOK-Restudy Behavioural Study/Data', 'subjmm47'); % change for person
if ~exist (analysisfolder)
    mkdir (analysisfolder);
end

%% Accuracy Chart

accuracy = data(:,9) == data (:,10);

%% Info

successrecallnumber = 0;
successFOK1 = 0;
successFOK2 = 0;
successFOK3 = 0;
successFOK4 = 0;
successFOK5 = 0;
successrecallrestudy = 0;
successrecallnostudy = 0;
successrecallright = 0;
successrecallwrong = 0;

for i = 1:length(data)
    if data (i, 4) == 1
        successrecallnumber = successrecallnumber + 1;
        if data (i, 5) == 1
            successFOK1 = successFOK1 + 1;
        elseif data (i, 5) == 2
            successFOK2 = successFOK2 + 1;
        elseif data (i, 5) == 3
            successFOK3 = successFOK3 + 1;
        elseif data (i, 5) == 4
            successFOK4 = successFOK4 + 1;
        elseif data (i, 5) == 5
            successFOK5 = successFOK5 + 1;
        end
        if data (i, 8) == 1
            successrecallrestudy = successrecallrestudy + 1;
        elseif data (i, 8) == 0
            successrecallnostudy = successrecallnostudy + 1;
            if accuracy (i) == 1
                successrecallright = successrecallright + 1;
            elseif accuracy (i) == 0
                successrecallwrong = successrecallwrong + 1;
            end
        end
    end
end

successrecallaccuracy =  successrecallright / (successrecallright + successrecallwrong) * 100;

successrecall = zeros (1, 9);
successrecall (1,1) = successrecallnumber;
successrecall (1,2) = successFOK1;
successrecall (1,3) = successFOK2;
successrecall (1,4) = successFOK3;
successrecall (1,5) = successFOK4;
successrecall (1,6) = successFOK5;
successrecall (1,7) = successrecallrestudy;
successrecall (1,8) = successrecallnostudy;
successrecall (1,9) = successrecallaccuracy;

arrayname = fullfile (analysisfolder, 'successtrials.txt');
dlmwrite (arrayname, successrecall);

successrecalltable = array2table (successrecall, 'VariableNames', {'SuccessRecallAmount', 'SuccessRecallFOK1',...
    'SuccessRecallFOK2', 'SuccessRecallFOK3', 'SuccessRecallFOK4', 'SuccessRecallFOK5', 'SuccessTrialsRestudied', ...
    'SuccessTrialsNotRestudied', 'SuccessNotRestudiedAccuracy'});
tablename = fullfile (analysisfolder, 'SuccessRecallTable.xlsx');
writetable (successrecalltable, tablename);
