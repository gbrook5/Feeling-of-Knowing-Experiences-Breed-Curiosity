%% Data Analysis for behavioural results

subjects = readtable(fullfile...
    ('C:\Users\gabro\Documents\Graduate Studies\Research\FOK-Restudy Behavioural Study\Numbers\Participants.xlsx'));
subjects = table2array(subjects);

for i = 1:length(subjects)
    
    subj = subjects(i,1);
    subj = char(subj);    
   
    genFolder = fullfile...
        ('C:\Users\gabro\Documents\Graduate Studies\Research\FOK-Restudy Behavioural Study\FOK-Restudy Experimental Paradigm\SubjectData');
    pFolder = fullfile (genFolder, subj); % Change according to who I'm analyzing
    data = load (fullfile (pFolder, 'participantresults.txt'));
    
    accuracy = data(:,9) == data (:, 10);
    
    % Calc Numbers for gammma
    
    veryhighFOKincorrect = 0;
    highFOKincorrect = 0;
    neutralFOKincorrect = 0;
    lowFOKincorrect =0;
    verylowFOKincorrect = 0;
    
    veryhighFOKcorrect = 0;
    highFOKcorrect = 0;
    neutralFOKcorrect = 0;
    lowFOKcorrect = 0;
    verylowFOKcorrect = 0;
    
    for i = 1:length(data)
        if data (i, 8) == 0 % if not restudied
            if data (i, 4) == 0 % if recall initially unsuccessful
                if data (i, 5) == 5 % if FOK 5
                    if accuracy (i) == 1 % if correct
                        veryhighFOKcorrect = veryhighFOKcorrect + 1; % + 1 to FOK5 correct
                    else  % else, must be wrong
                        veryhighFOKincorrect = veryhighFOKincorrect + 1; % + 1 to FOK5 incorrect
                    end
                elseif data (i, 5) == 4
                    if accuracy (i) == 1
                        highFOKcorrect = highFOKcorrect + 1;
                    else
                        highFOKincorrect = highFOKincorrect + 1;
                    end
                elseif data (i, 5) == 3
                    if accuracy (i) == 1
                        neutralFOKcorrect = neutralFOKcorrect + 1;
                    else
                        neutralFOKincorrect = neutralFOKincorrect + 1;
                    end
                elseif data (i, 5) == 2
                    if accuracy (i) == 1
                        lowFOKcorrect = lowFOKcorrect + 1;
                    else
                        lowFOKincorrect = lowFOKincorrect + 1;
                    end
                elseif data (i, 5) == 1
                    if accuracy (i) == 1
                        verylowFOKcorrect = verylowFOKcorrect + 1;
                    else
                        verylowFOKincorrect = verylowFOKincorrect + 1;
                    end
                end
            end
        end
    end
    
    FOKvsrightwrong = zeros (5,2); % save right vs wrong values
    
    FOKvsrightwrong (1,1) = verylowFOKincorrect;
    FOKvsrightwrong (2,1) = lowFOKincorrect;
    FOKvsrightwrong (3,1) = neutralFOKincorrect;
    FOKvsrightwrong (4,1) = highFOKincorrect;
    FOKvsrightwrong (5,1) = veryhighFOKincorrect;
    
    FOKvsrightwrong (1,2) = verylowFOKcorrect;
    FOKvsrightwrong (2,2) = lowFOKcorrect;
    FOKvsrightwrong (3,2) = neutralFOKcorrect;
    FOKvsrightwrong (4,2) = highFOKcorrect;
    FOKvsrightwrong (5,2) = veryhighFOKcorrect;
    
    % Gamma stat
    
    gkgammatst (FOKvsrightwrong, 0.05, 1); % matrix to be analyzed, alpha, tail
    
    gammainfo = [g GKasymototicSE significance]; % save current g and SE values as matrix
    
    datanew = [];
    accuracynew = [];
    
    for i =1:length(data)
        if data (i,4) == 0
            datanew = [datanew; data(i,:)];
            accuracynew = [accuracynew; accuracy(i)];
        end
    end
    
    dataprimed = [];
    accuracyprimed = [];
    dataunprimed = [];
    accuracyunprimed = [];
    
    for i = 1:length(datanew)
        if datanew (i,3) == 1
            dataprimed = [dataprimed; datanew(i,:)];
            accuracyprimed = [accuracyprimed; accuracy(i)];
        elseif datanew(i,3) == 0
            dataunprimed = [dataunprimed; datanew(i,:)];
            accuracyunprimed = [accuracyunprimed; accuracy(i)];
        end
    end
    
    primedFOK = mean(dataprimed(:,5));
    unprimedFOK = mean(dataunprimed(:,5));
    primedaccuracy = (sum(accuracyprimed))/(length(accuracyprimed)) * 100;
    unprimedaccuracy = (sum(accuracyunprimed))/(length(accuracyunprimed)) * 100;
    
    FOKs = [primedFOK, unprimedFOK, primedaccuracy, unprimedaccuracy];
    
    all = [gammainfo, FOKs];
    
    % Load Up Master File
    
    masterdata = load...
        ('C:\Users\gabro\Documents\Graduate Studies\Research\FOK-Restudy Behavioural Study\Data\Compiled Results\Revisions\RevisionFOKanalysis.txt');
    %import master data list
    
    masterdata = [masterdata; all]; % concactenate current matrix with master, replace master
    filename = fullfile ...
        ('C:\Users\gabro\Documents\Graduate Studies\Research\FOK-Restudy Behavioural Study\Data\Compiled Results\Revisions\RevisionFOKanalysis.txt');
    % save txt
    dlmwrite (filename, masterdata); % save new master in fill
    
    masterdatatable = array2table (masterdata, 'VariableNames', {'GammaCorrelation', 'GKasymototicSE', 'Signficance',...
        'AverageFOKRatingPrimed', 'AverageFOKRatingUnprimed', 'AverageAccuracyPrimed', 'AverageAccuracyUnprimed'});
    tablename = fullfile...
        ('C:\Users\gabro\Documents\Graduate Studies\Research\FOK-Restudy Behavioural Study\Data\Compiled Results\Revisions\RevisionFOKanalysis.xlsx');
    % save table
    writetable (masterdatatable, tablename);
    
end