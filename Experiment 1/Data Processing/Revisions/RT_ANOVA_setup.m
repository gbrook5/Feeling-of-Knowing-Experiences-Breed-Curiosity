%% Data Analysis for behavioural results

subjects = readtable(fullfile...
    ('C:\Users\gabro\Documents\Graduate Studies\Research\FOK-Restudy Behavioural Study\Numbers\Participants.xlsx'));
subjects = table2array(subjects);

for j = 1:length(subjects)
    
    subj = subjects(j,1);
    subj = char(subj);
    
    genFolder = fullfile...
        ('C:\Users\gabro\Documents\Graduate Studies\Research\FOK-Restudy Behavioural Study\FOK-Restudy Experimental Paradigm\SubjectData');
    pFolder = fullfile (genFolder, subj); % Change according to who I'm analyzing
    data = load (fullfile (pFolder, 'participantresults.txt'));
    
    RT = data(:,6) - data(:,7);

    % Calculate average RT for old restudy, old not restudy, new retsudy
    % and new not restudy - all trials
    
    RTprimedrestudy = 0;
    primedrestudy = 0;
    RTprimednot = 0;
    primednot = 0;
    RTunprimedrestudy = 0;
    unprimedrestudy = 0;
    RTunprimednot = 0;
    unprimednot = 0;
    
    for i = 1:length (data)
        if data (i,3) == 1 % if primed
            if data (i, 8) == 1 % if restudy
                primedrestudy = primedrestudy + 1;
                RTprimedrestudy = RTprimedrestudy + RT(i);
            elseif data(i,8) == 0 % if not restudy
                primednot = primednot + 1;
                RTprimednot = RTprimednot + RT(i);
            end
        elseif data (i,3) == 0 % if unprimed
            if data(i,8) == 1 % if restudy
                unprimedrestudy = unprimedrestudy + 1;
                RTunprimedrestudy = RTunprimedrestudy + RT(i);
            elseif data (i,8) == 0 % if not
                unprimednot = unprimednot + 1;
                RTunprimednot = RTunprimednot + RT(i);
            end
        end
    end
        
    % Calculate Average RTs
    
    AllPrimedRestudyRTavg = RTprimedrestudy/primedrestudy;
    AllPrimedNotRestudyRTavg = RTprimednot/primednot;
    AllUnprimedRestudyRTavg = RTunprimedrestudy/unprimedrestudy;
    AllUnprimedNotRestudyRTavg = RTunprimednot/unprimednot;
    
    % Repeat for No Success Trials Only
    
    RTprimedrestudy = 0;
    primedrestudy = 0;
    RTprimednot = 0;
    primednot = 0;
    RTunprimedrestudy = 0;
    unprimedrestudy = 0;
    RTunprimednot = 0;
    unprimednot = 0;
    
    for i = 1:length (data)
        if data (i, 4) == 0 % if initially unsuccessfully recalled
            if data (i,3) == 1 % if primed
                if data (i, 8) == 1 % if restudy
                    primedrestudy = primedrestudy + 1;
                    RTprimedrestudy = RTprimedrestudy + RT(i);
                elseif data(i,8) == 0 % if not restudy
                    primednot = primednot + 1;
                    RTprimednot = RTprimednot + RT(i);
                end
            elseif data (i,3) == 0 % if unprimed
                if data(i,8) == 1 % if restudy
                    unprimedrestudy = unprimedrestudy + 1;
                    RTunprimedrestudy = RTunprimedrestudy + RT(i);
                elseif data (i,8) == 0 % if not
                    unprimednot = unprimednot + 1;
                    RTunprimednot = RTunprimednot + RT(i);
                end
            end
        end
    end
    
    % Calculate Average RTs
    
    NoSuccessPrimedRestudyRTavg = RTprimedrestudy/primedrestudy;
    NoSuccessPrimedNotRestudyRTavg = RTprimednot/primednot;
    NoSuccessUnprimedRestudyRTavg = RTunprimedrestudy/unprimedrestudy;
    NoSuccessUnprimedNotRestudyRTavg = RTunprimednot/unprimednot;
    
    % Chart
    
    RTdata = zeros (1,8);
    RTdata (1,1) = AllPrimedRestudyRTavg;
    RTdata (1,2) = AllPrimedNotRestudyRTavg;
    RTdata (1,3) = AllUnprimedRestudyRTavg;
    RTdata (1,4) = AllUnprimedNotRestudyRTavg;
    RTdata (1,5) = NoSuccessPrimedRestudyRTavg;
    RTdata (1,6) = NoSuccessPrimedNotRestudyRTavg;
    RTdata (1,7) = NoSuccessUnprimedRestudyRTavg;
    RTdata (1,8) = NoSuccessUnprimedNotRestudyRTavg;
    
    % Load Up Master File
    
    masterdata = load...
        ('C:\Users\gabro\Documents\Graduate Studies\Research\FOK-Restudy Behavioural Study\Data\Compiled Results\Revisions\RevisionRTANOVAinput.txt');
    %import master data list
    
    masterdata = [masterdata; RTdata]; % concactenate current matrix with master, replace master
    filename = fullfile ...
        ('C:\Users\gabro\Documents\Graduate Studies\Research\FOK-Restudy Behavioural Study\Data\Compiled Results\Revisions\RevisionRTANOVAinput.txt');
    % save txt
    dlmwrite (filename, masterdata); % save new master in fill
    
    masterdatatable = array2table (masterdata, 'VariableNames', {'PrimedRestudyRTAverageAll',...
        'PrimedNotRestudyRTAverageAll', 'UnprimedRestudyRTAverageAll', 'UnprimedNotRestudyRTAverageAll',...
        'PrimedRestudyRTAverageNoSuccess', 'PrimedNotRestudyRTAverageNoSuccess', 'UnprimedRestudyRTAverageNoSuccess',...
        'UnprimedNotRestudyRTAverageNoSuccess'});
    tablename = fullfile...
        ('C:\Users\gabro\Documents\Graduate Studies\Research\FOK-Restudy Behavioural Study\Data\Compiled Results\Revisions\RevisionRTANOVAinput.xlsx');
    % save table
    writetable (masterdatatable, tablename);
    
end

%% All trials

all = [masterdata(:,1); masterdata(:,2); masterdata(:,3); masterdata(:,4)]; % get all trial info

restudy = ones(length(subjects),1); 
norestudy = zeros(length(subjects),1);    
primed = ones(length(subjects),1);
unprimed = zeros(length(subjects),1);
subj = [1:length(subjects)]';

status = [primed; primed; unprimed; unprimed];
choice = [restudy; norestudy; restudy; norestudy];
subject = [subj; subj; subj; subj];
factnames = {'Status', 'Choice'};

stats = rm_anova2(all,subject,status,choice,factnames)

%% No Success Trials

all = [masterdata(:,5); masterdata(:,6); masterdata(:,7); masterdata(:,8)]; % get all trial info

restudy = ones(length(subjects),1); 
norestudy = zeros(length(subjects),1);    
primed = ones(length(subjects),1);
unprimed = zeros(length(subjects),1);
subj = [1:length(subjects)]';

status = [primed; primed; unprimed; unprimed];
choice = [restudy; norestudy; restudy; norestudy];
subject = [subj; subj; subj; subj];
factnames = {'Status', 'Choice'};

stats2 = rm_anova2(all,subject,status,choice,factnames)