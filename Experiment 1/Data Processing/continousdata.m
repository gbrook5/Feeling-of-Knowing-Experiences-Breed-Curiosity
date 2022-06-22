% Continuous data analysis

genFolder = fullfile ('C:/Users/gabro/Documents/Graduate Studies/Research/FOK-Restudy Behavioural Study/FOK-Restudy Experimental Paradigm/SubjectData');
pFolder = fullfile (genFolder, 'subjmm47'); % Change according to who I'm analyzing
data = load (fullfile (pFolder, 'participantresults.txt'));

analysisfolder = fullfile ('C:/Users/gabro/Documents/Graduate Studies/Research/FOK-Restudy Behavioural Study/Data', 'subjmm47'); % change for person
if ~exist (analysisfolder)
    mkdir (analysisfolder);
end

%% Calculate Totals and Restudy Numbers for all FOK levels 

FOK1total = 0;
FOK2total = 0;
FOK3total = 0;
FOK4total = 0;
FOK5total = 0;

FOK1restudy = 0;
FOK2restudy = 0;
FOK3restudy = 0;
FOK4restudy = 0;
FOK5restudy = 0;

for i = 1:length(data)
    if data (i, 4) == 0
        if data (i, 5) == 1
            FOK1total = FOK1total + 1;
            if data (i, 8) == 1 % change 8 to 6 if doing subject 4 or earlier
                FOK1restudy = FOK1restudy + 1;
            end
        end
        if data (i, 5) == 2
            FOK2total = FOK2total + 1;
            if data (i, 8) == 1 % change 8 to 6 if doing subject 4 or earlier
                FOK2restudy = FOK2restudy + 1;
            end
        end
        if data (i, 5) == 3
            FOK3total = FOK3total + 1;
            if data (i, 8) == 1 % change 8 to 6 if doing subject 4 or earlier
                FOK3restudy = FOK3restudy + 1;
            end
        end
        if data (i, 5) == 4
            FOK4total = FOK4total + 1;
            if data (i, 8) == 1 % change 8 to 6 if doing subject 4 or earlier
                FOK4restudy = FOK4restudy + 1;
            end
        end
        if data (i, 5) == 5
            FOK5total = FOK5total + 1;
            if data (i, 8) == 1 % change 8 to 6 if doing subject 4 or earlier
                FOK5restudy = FOK5restudy + 1;
            end
        end
    end
end

%% Chart, Save and Export

FOKnumbers = zeros (1,10);
FOKnumbers (1,1) = FOK1total;
FOKnumbers (1,2) = FOK1restudy;
FOKnumbers (1,3) = FOK2total;
FOKnumbers (1,4) = FOK2restudy;
FOKnumbers (1,5) = FOK3total;
FOKnumbers (1,6) = FOK3restudy;
FOKnumbers (1,7) = FOK4total;
FOKnumbers (1,8) = FOK4restudy;
FOKnumbers (1,9) = FOK5total;
FOKnumbers (1,10) = FOK5restudy;
            
arrayname = fullfile (analysisfolder, 'FOKRestduyTotals.txt');
dlmwrite (arrayname, FOKnumbers);

FOKrestudydatatable = array2table (FOKnumbers, 'VariableNames', {'FOKRating1Total', 'FOKRating1Restudy'...
    'FOKRating2Total', 'FOKRating2Restudy', 'FOKRating3Total', 'FOKRating3Restudy', 'FOKRating4Total', ...
    'FOKRating4Restudy', 'FOKRating5Total', 'FOKRating5Restudy'});
tablename = fullfile (analysisfolder, 'FOKRestudyTotals.xlsx');
writetable (FOKrestudydatatable, tablename);