%% Setting up a Proportion Restudied vs FOK and Primed/Unprimed 
% will be a chart with all participants as rows, 10 columns (unprimed and
% primed for 5 levels of FOK ratings)
% values in chart will be % restudied

%% Import data

genFolder = fullfile ('C:/Users/gabro/Documents/Graduate Studies/Research/FOK-Restudy Behavioural Study/FOK-Restudy Experimental Paradigm/SubjectData');
pFolder = fullfile (genFolder, 'subjmm47'); % Change according to who I'm analyzing
data = load (fullfile (pFolder, 'participantresults.txt'));

%% Set up Variables

FOK1NotPrimedRestudied = 0;
FOK1NotPrimedTotal = 0;
FOK1PrimedRestudied = 0;
FOK1PrimedTotal = 0;

FOK2NotPrimedRestudied = 0;
FOK2NotPrimedTotal = 0;
FOK2PrimedRestudied = 0;
FOK2PrimedTotal = 0;

FOK3NotPrimedRestudied = 0;
FOK3NotPrimedTotal = 0;
FOK3PrimedTotal = 0;
FOK3PrimedRestudied = 0;

FOK4NotPrimedRestudied = 0;
FOK4NotPrimedTotal = 0;
FOK4PrimedRestudied = 0;
FOK4PrimedTotal = 0;

FOK5NotPrimedRestudied = 0;
FOK5NotPrimedTotal = 0;
FOK5PrimedRestudied = 0;
FOK5PrimedTotal = 0;

for i = 1:length (data)
    if data (i, 5) == 1 % if FOK is a 1
        if data (i, 3) == 1 % if it was primed
            FOK1PrimedTotal = FOK1PrimedTotal + 1; % add 1 to FOK1-Primed tally
            if data (i, 8) == 1 % if it was also restudied
                FOK1PrimedRestudied = FOK1PrimedRestudied + 1; % add 1 to FOK1-Primed-Restudied tally
            end
        elseif data (i, 3) == 0 % if it was not primed, add to unprimed tallies in same way
            FOK1NotPrimedTotal = FOK1NotPrimedTotal + 1;
            if data (i, 8) == 1
                FOK1NotPrimedRestudied = FOK1NotPrimedRestudied + 1;
            end
        end
    end
    if data (i, 5) == 2 % repeat for all FOK levels
        if data (i, 3) == 1
            FOK2PrimedTotal = FOK2PrimedTotal + 1;
            if data (i, 8) == 1
                FOK2PrimedRestudied = FOK2PrimedRestudied + 1;
            end
        elseif data (i, 3) == 0
            FOK2NotPrimedTotal = FOK2NotPrimedTotal + 1;
            if data (i, 8) == 1
                FOK2NotPrimedRestudied = FOK2NotPrimedRestudied + 1;
            end
        end
    end
    if data (i, 5) == 3
        if data (i, 3) == 1
            FOK3PrimedTotal = FOK3PrimedTotal + 1;
            if data (i, 8) == 1
                FOK3PrimedRestudied = FOK3PrimedRestudied + 1;
            end
        elseif data (i, 3) == 0
            FOK3NotPrimedTotal = FOK3NotPrimedTotal + 1;
            if data (i, 8) == 1
                FOK3NotPrimedRestudied = FOK3NotPrimedRestudied + 1;
            end
        end
    end
    if data (i, 5) == 4
        if data (i, 3) == 1
            FOK4PrimedTotal = FOK4PrimedTotal + 1;
            if data (i, 8) == 1
                FOK4PrimedRestudied = FOK4PrimedRestudied + 1;
            end
        elseif data (i, 3) == 0
            FOK4NotPrimedTotal = FOK4NotPrimedTotal + 1;
            if data (i, 8) == 1
                FOK4NotPrimedRestudied = FOK4NotPrimedRestudied + 1;
            end
        end
    end
    if data (i, 5) == 5
        if data (i, 3) == 1
            FOK5PrimedTotal = FOK5PrimedTotal + 1;
            if data (i, 8) == 1
                FOK5PrimedRestudied = FOK5PrimedRestudied + 1;
            end
        elseif data (i, 3) == 0
            FOK5NotPrimedTotal = FOK5NotPrimedTotal + 1;
            if data (i, 8) == 1
                FOK5NotPrimedRestudied = FOK5NotPrimedRestudied + 1;
            end
        end
    end
end

%% Now calculate Proportion Restudied

FOK1ProportionRestudiedPrimed = (FOK1PrimedRestudied / FOK1PrimedTotal) * 100;
FOK1ProportionRestudiedUnPrimed = (FOK1NotPrimedRestudied / FOK1NotPrimedTotal) * 100;

FOK2ProportionRestudiedPrimed = (FOK2PrimedRestudied / FOK2PrimedTotal) * 100;
FOK2ProportionRestudiedUnPrimed = (FOK2NotPrimedRestudied / FOK2NotPrimedTotal) * 100;

FOK3ProportionRestudiedPrimed = (FOK3PrimedRestudied / FOK3PrimedTotal) * 100;
FOK3ProportionRestudiedUnPrimed = (FOK3NotPrimedRestudied / FOK3NotPrimedTotal) * 100;

FOK4ProportionRestudiedPrimed = (FOK4PrimedRestudied / FOK4PrimedTotal) * 100;
FOK4ProportionRestudiedUnPrimed = (FOK4NotPrimedRestudied / FOK4NotPrimedTotal) * 100;

FOK5ProportionRestudiedPrimed = (FOK5PrimedRestudied / FOK5PrimedTotal) * 100;
FOK5ProportionRestudiedUnPrimed = (FOK5NotPrimedRestudied / FOK5NotPrimedTotal) * 100;

%% Construct Table

newvalues = zeros (1, 10);
newvalues (1,1) = FOK1ProportionRestudiedPrimed;
newvalues (1,2) = FOK1ProportionRestudiedUnPrimed;
newvalues (1,3) = FOK2ProportionRestudiedPrimed;
newvalues (1,4) = FOK2ProportionRestudiedUnPrimed;
newvalues (1,5) = FOK3ProportionRestudiedPrimed;
newvalues (1,6) = FOK3ProportionRestudiedUnPrimed;
newvalues (1,7) = FOK4ProportionRestudiedPrimed;
newvalues (1,8) = FOK4ProportionRestudiedUnPrimed;
newvalues (1,9) = FOK5ProportionRestudiedPrimed;
newvalues (1,10) = FOK5ProportionRestudiedUnPrimed;

%%
greattable = load (fullfile('C://Users/gabro/Documents/Graduate Studies/Research/FOK-Restudy Behavioural Study/Analysis',...
    'RestudiedvsFOKvsPrime.txt'));
greattable = [greattable; newvalues]; 
dlmwrite (fullfile('C://Users/gabro/Documents/Graduate Studies/Research/FOK-Restudy Behavioural Study/Analysis', 'RestudiedvsFOKvsPrime.txt'), greattable);

greattabletable = array2table (greattable, 'VariableNames', {'FOK1Primed', 'FOK1Unprimed', 'FOK2Primed',...
    'FOK2Unprimed', 'FOK3Primed', 'FOK3Unprimed', 'FOK4Primed', 'FOK4Unprimed', 'FOK5Primed', 'FOK5Unprimed'});
writetable(greattabletable, 'RestudiedvsFOKvsPrime_table.xlsx');

