%% Data Analysis for behavioural results

subjects = readtable(fullfile...
    ('C:\Users\gabro\Documents\Graduate Studies\Research\FOK-Restudy Behavioural Study\Numbers\Participants.xlsx'));
subjects = table2array(subjects);

for j = 1:length(subjects)
    
    subj = subjects(j,1);
    subj = char(subj);
    genFolder = fullfile...
        ('C:/Users/gabro/Documents/Graduate Studies/Research/FOK-Restudy Behavioural Study/FOK-Restudy Experimental Paradigm/SubjectData');
    pFolder = fullfile (genFolder, subj);
    data = load (fullfile (pFolder, 'participantresults.txt'));
    
    RT = data(:,6) - data(:,7); % calc RT
    
    [rall, pall] = corr(data(:,5),RT(:), 'Type','Spearman');
    if pall <= 0.05
        sigall = 1;
    else
        sigall = 0;
    end
    corrs = [rall pall sigall];
    
    datanew = [];
    
    for i =1:length(data)
        if data (i,4) == 0
            datanew = [datanew; data(i,:)]; % remove successful trials
        end
    end
    
    RTnew = datanew(:,6) - datanew(:,7); % calc RT
    
    [rno, pno] = corr(datanew(:,5),RTnew(:), 'Type','Spearman');
    if pno <= 0.05
        signo = 1;
    else
        signo = 0;
    end
    corrsno = [rno pno signo];
    
    % Chart
    
    RT = [corrs, corrsno];
    
    % Load Up Master File
    
    masterdata = load...
        ('C:\Users\gabro\Documents\Graduate Studies\Research\FOK-Restudy Behavioural Study\Data\Compiled Results\Revisions\RevisionFOKRTCorr.txt');
    %import master data list
    
    masterdata = [masterdata; RT]; % concactenate current matrix with master, replace master
    filename = fullfile ...
        ('C:\Users\gabro\Documents\Graduate Studies\Research\FOK-Restudy Behavioural Study\Data\Compiled Results\Revisions\RevisionFOKRTCorr.txt');
    % save txt
    dlmwrite (filename, masterdata); % save new master in fill
    
    masterdatatable = array2table (masterdata, 'VariableNames', {'SpearmanCorrelationAll',...
        'SpearmanCorrelationPValAll', 'SpearmanCorrelationSignificanceAll',...
        'SpearmanCorrelationNoSuccess', 'SpearmanCorrelationPValNoSuccess', 'SpearmanCorrelationSignificanceNoSuccess'});
    tablename = fullfile...
        ('C:\Users\gabro\Documents\Graduate Studies\Research\FOK-Restudy Behavioural Study\Data\Compiled Results\Revisions\RevisionFOKRTCorr.xlsx');
    % save table
    writetable (masterdatatable, tablename);
    
end

