%% Data Analysis for behavioural results

subjects = readtable(fullfile...
    ('C:\Users\gabro\Documents\Graduate Studies\Research\FOK-Restudy Behavioural Study\Numbers\Participants.xlsx'));
subjects = table2array(subjects);
masterdata = [];

for j = 1:length(subjects)
    
    subj = subjects(j,1);
    subj = char(subj);
    
    genFolder = fullfile...
        ('C:\Users\gabro\Documents\Graduate Studies\Research\FOK-Restudy Behavioural Study\FOK-Restudy Experimental Paradigm\SubjectData');
    pFolder = fullfile (genFolder, subj); % Change according to who I'm analyzing
    data = load (fullfile (pFolder, 'participantresults.txt'));
    
    % FOK average for unprimed + primed restudied vs not restudied
    % 2x2 style
    
    primedrestudyFOKtotal = 0;
    primedrestudy = 0;
    primednotrestudyFOKtotal = 0;
    primednotrestudy = 0;
    unprimedrestudyFOKtotal = 0;
    unprimedrestudy = 0;
    unprimednotrestudyFOKtotal = 0;
    unprimednotrestudy = 0;
    
    for i = 1:length (data)
        if data (i,4) == 0 % if recall unsuccessful
            if data (i,3) == 1 % if primed
                if data (i, 8) == 1 % if restudy
                    primedrestudy = primedrestudy + 1;
                    primedrestudyFOKtotal = primedrestudyFOKtotal + data(i,5);
                elseif data(i,8) == 0 % if not restudy
                    primednotrestudy = primednotrestudy + 1;
                    primednotrestudyFOKtotal = primednotrestudyFOKtotal + data(i,5);
                end
            elseif data (i,3) == 0 % if unprimed
                if data(i,8) == 1 % if restudy
                    unprimedrestudy = unprimedrestudy + 1;
                    unprimedrestudyFOKtotal = unprimedrestudyFOKtotal + data(i,5);
                elseif data (i,8) == 0 % if not
                    unprimednotrestudy = unprimednotrestudy + 1;
                    unprimednotrestudyFOKtotal = unprimednotrestudyFOKtotal + data(i,5);
                end
            end
        end
    end
        
    % Calculate Average RTs
    
    PrimedRestudyFOKavg = primedrestudyFOKtotal/primedrestudy;
    PrimedNotRestudyFOKavg = primednotrestudyFOKtotal/primednotrestudy;
    UnprimedRestudyFOKavg = unprimedrestudyFOKtotal/unprimedrestudy;
    UnprimedNotRestudyFOKavg = unprimednotrestudyFOKtotal/unprimednotrestudy;
    
    % Chart
    
    RTdata = zeros (1,4);
    RTdata (1,1) = PrimedRestudyFOKavg;
    RTdata (1,2) = PrimedNotRestudyFOKavg;
    RTdata (1,3) = UnprimedRestudyFOKavg;
    RTdata (1,4) = UnprimedNotRestudyFOKavg;
    
    masterdata = [masterdata; RTdata]; % concactenate current matrix with master, replace master
    
end


