% Gen 

subjID = 'subjmm47';
genFolder = fullfile...
    ('C:/Users/gabro/Documents/Graduate Studies/Research/FOK-Restudy Behavioural Study/FOK-Restudy Experimental Paradigm/SubjectData');
pFolder = fullfile (genFolder, subjID); % Change according to who I'm analyzing
data = load (fullfile (pFolder, 'participantresults.txt'));

analysisfolder = fullfile...
    ('C:/Users/gabro/Documents/Graduate Studies/Research/FOK-Restudy Behavioural Study/Data/Compiled Results');
if ~exist (analysisfolder)
    mkdir (analysisfolder);
end

%% Calculate Proportions/mean FOK ratings/restudy proportions

accuracy = data(:,9) == data(:,10);

primesuccess = 0;
unprimesuccess = 0;
primenosuccess = 0;
uneprimenosuccess = 0;
primetotal = 0;
unprimetotal = 0;

primesuccessFOK = 0;
unprimesuccessFOK = 0;
primenosuccessFOK = 0;
unprimenosuccessFOK = 0;
primetotalFOK = 0;
unprimetotalFOK = 0;

primesuccessRestudy = 0;
unprimesuccessRestudy = 0;
primenosuccessRestudy = 0;
unprimenosuccessRestudy = 0;
primetotalRestudy = 0;
unprimetotalRestudy = 0;

primesuccessCorrect = 0;
unprimesuccessCorrect = 0;
primenosuccessCorrect = 0;
unprimenosuccessCorrect = 0;
primetotalCorrect = 0;
unprimetotalCorrect = 0;

for i = 1:length(data)
    if data(i,3) == 1 % if prime
        primetotal = primetotal + 1;
        if data(i,4) == 0 % if no success
            primenosuccess = primenosuccess + 1;
            primenosuccessFOK = primenosuccessFOK + data(i,5);
            if data(i,8) == 0 % if not restudy
                if accuracy (i) == 1
                    primenosuccessCorrect = primenosuccessCorrect + 1;
                end
            elseif data(i,8) == 1 % if restudy
                primenosuccessRestudy = primenosuccessRestudy + 1;
            end
        elseif data(i,4) == 1 % if success
            primesuccess = primesuccess + 1;
            primesuccessFOK = primesuccessFOK + data(i,5);
            if data(i,8) == 0
                if accuracy (i) == 1
                    primesuccessCorrect = primesuccessCorrect + 1;
                end
            elseif data(i,8) == 1
                primesuccessRestudy = primesuccessRestudy + 1;
            end
        end
    elseif data(i,3) == 0 % unprimed
        unprimetotal = unprimetotal + 1;
        if data(i,4) == 0 % if no success
            uneprimenosuccess = uneprimenosuccess + 1;
            unprimenosuccessFOK = unprimenosuccessFOK + data(i,5);
            if data(i,8) == 0 % if not restudy
                if accuracy (i) == 1
                    unprimenosuccessCorrect = unprimenosuccessCorrect + 1;
                end
            elseif data(i,8) == 1 % if restudy
                unprimenosuccessRestudy = unprimenosuccessRestudy + 1;
            end
        elseif data(i,4) == 1 % if success
            unprimesuccess = unprimesuccess + 1;
            unprimesuccessFOK = unprimesuccessFOK + data(i,5);
            if data(i,8) == 0
                if accuracy (i) == 1
                    unprimesuccessCorrect = unprimesuccessCorrect + 1;
                end
            elseif data(i,8) == 1
                unprimesuccessRestudy = unprimesuccessRestudy + 1;
            end
        end
    end
end

primetotalFOK = primenosuccessFOK + primesuccessFOK;
unprimetotalFOK = unprimenosuccessFOK + unprimesuccessFOK;
primetotalRestudy = primenosuccessRestudy + primesuccessRestudy;
unprimetotalRestudy = unprimenosuccessRestudy + unprimesuccessRestudy;
primetotalCorrect = primenosuccessCorrect + primesuccessCorrect;
unprimetotalCorrect = unprimenosuccessCorrect + unprimesuccessCorrect;

primesuccessproportion = primesuccess / primetotal;
primenosuccessproportion = primenosuccess / primetotal;
primetotalproportion = primetotal / primetotal;
unprimesuccessproportion = unprimesuccess / unprimetotal;
unprimenosuccessproportion = uneprimenosuccess / unprimetotal;
unprimetotalproportion = unprimetotal / unprimetotal;

primesuccessavgFOK = primesuccessFOK / primesuccess;
primenosuccessavgFOK = primenosuccessFOK / primenosuccess;
primeavgFOK = primetotalFOK / primetotal;
unprimesuccessavgFOK = unprimesuccessFOK / unprimesuccess;
unprimenosuccessavgFOK = unprimenosuccessFOK / uneprimenosuccess;
unprimeavgFOK = unprimetotalFOK / unprimetotal;

primesuccessavgRestudy = primesuccessRestudy / primesuccess;
primenosuccessavgRestudy = primenosuccessRestudy / primenosuccess;
primeRestudy = primetotalRestudy / primetotal;
unprimesuccessavgRestudy = unprimesuccessRestudy / unprimesuccess;
unprimenosuccessavgRestudy = unprimenosuccessRestudy / uneprimenosuccess;
unprimeRestudy = unprimetotalRestudy / unprimetotal;

primesuccessAccuracy = primesuccessCorrect / (primesuccess - primesuccessRestudy);
primenosuccessAccuracy = primenosuccessCorrect / (primenosuccess - primenosuccessRestudy);
primeAccuracy = primetotalCorrect / (primetotal - primetotalRestudy);
unprimesuccessAccuracy = unprimesuccessCorrect / (unprimesuccess - unprimesuccessRestudy);
unprimenosuccessAccuracy = unprimenosuccessCorrect / (uneprimenosuccess - unprimenosuccessRestudy);
unprimeAccuracy = unprimetotalCorrect / (unprimetotal - unprimetotalRestudy);

%% Chart

numbers = zeros (1, 24);
numbers(1,1) = primetotalproportion;
numbers(1,2) = primenosuccessproportion;
numbers(1,3) = primesuccessproportion;
numbers(1,4) = unprimetotalproportion;
numbers(1,5) = unprimenosuccessproportion;
numbers(1,6) = unprimesuccessproportion;
numbers(1,7) = primeavgFOK;
numbers(1,8) = primenosuccessavgFOK;
numbers(1,9) = primesuccessavgFOK;
numbers(1,10) = unprimeavgFOK;
numbers(1,11) = unprimenosuccessavgFOK;
numbers(1,12) = unprimesuccessavgFOK;
numbers(1,13) = primeRestudy;
numbers(1,14) = primenosuccessavgRestudy;
numbers(1,15) = primesuccessavgRestudy;
numbers(1,16) = unprimeRestudy;
numbers(1,17) = unprimenosuccessavgRestudy;
numbers(1,18) = unprimesuccessavgRestudy;
numbers(1,19) = primeAccuracy;
numbers(1,20) = primenosuccessAccuracy;
numbers(1,21) = primesuccessAccuracy;
numbers(1,22) = unprimeAccuracy;
numbers(1,23) = unprimenosuccessAccuracy;
numbers(1,24) = unprimesuccessAccuracy;
    
%% Load Up Master File

filename = fullfile ...
    (analysisfolder, 'NumberInformation.txt');
masterdata = load...
    (filename); %import master data list

masterdata = [masterdata; numbers]; % concactenate current matrix with master, replace master
dlmwrite (filename, masterdata); % save new master in fill

masterdatatable = array2table (masterdata, 'VariableNames', {'PrimeTotalProportion',...
    'PrimeNoSuccessProportion', 'PrimeSuccessProportion', 'UnprimeTotalProportion',...
    'UnprimeNoSuccessProportion', 'UnprimeSuccessProportion', 'AllPrimeAverageFOK',...
    'PrimeNoSuccessAverageFOK', 'PrimeSuccessAverageFOK', 'AllUnprimeAverageFOK',...
    'UnprimeNoSuccessAverageFOK', 'UnprimeSuccessAverageFOK', 'TotalPrimeRestudyProportion',...
    'PrimeNoSuccessRestudyProportion', 'PrimeSuccessRestudyProportion', 'TotalUnprimeRestudyProportion',...
    'UnprimeNoSuccessRestudyProportion', 'UnprimeSuccessRestudyProportion', 'PrimeAccuracyNotRestudied',...
    'PrimeNoSuccessNoRestudyAccuracy', 'PrimeSuccessNoRestudyAccuracy', 'UnprimeAccuracyNotRestudy',...
    'UnprimeNoSuccessNoRestudyAccuracy', 'UnprimeSuccessNoRestudyAccuracy'});
tablename = fullfile...
    (analysisfolder, 'NumberInformationTable.xlsx');
writetable (masterdatatable, tablename); 