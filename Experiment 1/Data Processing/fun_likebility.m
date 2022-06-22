%% fun script exploring influence of likeability on FOK 

genFolder = fullfile ('C:/Users/gabro/Documents/Graduate Studies/Research/Experimental Paradigm/SubjectData');
pFolder = fullfile (genFolder, 'subjmm47'); % Change according to who I'm analyzing
data = load (fullfile (pFolder, 'participantresults.txt'));

analysisfolder = fullfile ('C:/Users/gabro/Documents/Graduate Studies/Research/Data', 'subjmm47'); % change for person
if ~exist (analysisfolder)
    mkdir (analysisfolder);
end

%% does higher likeability lead to higher FOK

highlyunlike = 0;
unlike = 0;
neutral = 0;
like = 0;
highlylike = 0;

highlyunlikeFOK = 0;
unlikeFOK = 0;
neutralFOK = 0;
likeFOK = 0;
highlylikeFOK = 0;

for i = 1:26
    if data (i, 2) == 1
        highlyunlike = highlyunlike + 1;
        highlyunlikeFOK = highlyunlikeFOK + data (i, 5);
    elseif data (i, 2) == 2
        unlike = unlike + 1;
        unlikeFOK = unlikeFOK + data (i, 5);
    elseif data (i, 2) == 3
        neutral = neutral + 1;
        neutralFOK = neutralFOK + data (i,5);
    elseif data (i,2) == 4
        like = like + 1;
        likeFOK = likeFOK + data (i,5);
    elseif data (i,2) == 5
        highlylike = highlylike + 1;
        highlylikeFOK = highlylikeFOK + data (i, 5);
    end
end

highlyunlikeFOKav = highlyunlikeFOK / highlyunlike;
unlikeFOKav = unlikeFOK / unlike;
neutralFOKav = neutralFOK / neutral;
likeFOKav = likeFOK/ like;
highlylikeFOKav = highlylikeFOK / highlylike;

%% Save

likeabilityFOK = zeros (1,5);
likeabilityFOK (1,1) = highlyunlikeFOKav;
likeabilityFOK (1,2) = unlikeFOKav;
likeabilityFOK (1,3) = neutralFOKav;
likeabilityFOK (1,4) = likeFOKav;
likeabilityFOK (1,5) = highlylikeFOKav;
            
arrayname = fullfile (analysisfolder, 'likeabilityFOK.txt');
dlmwrite (arrayname, likeabilityFOK);

likeabilityFOKtable = array2table (likeabilityFOK, 'VariableNames', {'Likeability1FOK', 'Likeability2FOK', ...
    'Likeability3FOK', 'Likeability4FOK', 'Likeability5FOK'});
tablename = fullfile (analysisfolder, 'LikeabilityFOKTable.xlsx');
writetable (likeabilityFOKtable, tablename);

