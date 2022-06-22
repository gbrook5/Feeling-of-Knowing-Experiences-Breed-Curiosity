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
        
    datanew = [];
    accuracynew = [];
    
    for i = 1:length(data)
        if data (i,4) == 0
            if data(i,8) == 0
                datanew = [datanew; data(i,:)];
                accuracynew = [accuracynew; accuracy(i)];
            end
        end
    end

    accuracyprimed = [];
    accuracyunprimed = [];
    
    for i = 1:length(datanew)
        if datanew (i,3) == 1
            accuracyprimed = [accuracyprimed; accuracynew(i)];
        elseif datanew(i,3) == 0
            accuracyunprimed = [accuracyunprimed; accuracynew(i)];
        end
    end
    
    primedaccuracy = (sum(accuracyprimed))/(length(accuracyprimed)) * 100;
    unprimedaccuracy = (sum(accuracyunprimed))/(length(accuracyunprimed)) * 100;
    
    FOKs = [primedaccuracy, unprimedaccuracy];
        
    % Load Up Master File
    
    masterdata = load...
        ('C:\Users\gabro\Documents\Graduate Studies\Research\FOK-Restudy Behavioural Study\Data\Compiled Results\Revisions\RevisionPrimingAccuracy.txt');
    %import master data list
    
    masterdata = [masterdata; FOKs]; % concactenate current matrix with master, replace master
    filename = fullfile ...
        ('C:\Users\gabro\Documents\Graduate Studies\Research\FOK-Restudy Behavioural Study\Data\Compiled Results\Revisions\RevisionPrimingAccuracy.txt');
    % save txt
    dlmwrite (filename, masterdata); % save new master in fill
    
    masterdatatable = array2table (masterdata, 'VariableNames', {'AverageAccuracyPrimed', 'AverageAccuracyUnprimed'});
    tablename = fullfile...
        ('C:\Users\gabro\Documents\Graduate Studies\Research\FOK-Restudy Behavioural Study\Data\Compiled Results\Revisions\RevisionPrimingAccuracy.xlsx');
    % save table
    writetable (masterdatatable, tablename);
    
end