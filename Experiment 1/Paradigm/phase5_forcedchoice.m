 % FOK-Restudy Paradigm

% Phase 5 - Forced Choice Test

%% Screen Setup
PsychDefaultSetup (2);
screens = Screen ('Screens');
screenNumber = max(screens);

black = BlackIndex (screenNumber);
white = WhiteIndex (screenNumber);
grey = white/2;

[window, windowRect] = PsychImaging ('OpenWindow', screenNumber, grey);

Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
[xCenter, yCenter] = RectCenter (windowRect);
ifi = Screen ('GetFlipInterval', window);

%% Timing Information

isiTimeSecs = 0.5; 
isiTimeFrames = round(isiTimeSecs / ifi);

%% Images

% imageFolderPractice = [filesep 'home' filesep 'gbrooks' filesep 'Documents' filesep...
%     'FOK-Restudy Experimental Paradigm' filesep 'All Faces' filesep 'Face Sets Organized' filesep...
%     'Face Set 1' filesep 'Practice' filesep];

imageFolderTask = ['C:' filesep 'Users' filesep 'gabro' filesep 'Documents' filesep...
    'Graduate Studies' filesep 'Research' filesep 'FOK-Restudy Behavioural Study' ...
    'FOK-Restudy Experimental Paradigm' filesep 'Encoding Faces' filesep];
trialnumber = 78;  
% trialnumbertotal = 83;  

%% Names

if namesetmat == 1
    namesreal = readtable ('Names.xlsx', 'Sheet', 'Name Set 1', 'Range', 'A1:B79');
elseif namesetmat == 2
    namesreal = readtable ('Names.xlsx', 'Sheet', 'Name Set 2', 'Range', 'A1:B79');
end
namesreal = table2array (namesreal);  
namesreal = string(namesreal);
firstnamereal = namesreal(:,1);
lastnamereal = namesreal (:,2);
bothnamesreal = strcat(firstnamereal, {' '},lastnamereal);
bothnamesreal = char(bothnamesreal);

if namesetmat == 1
    namesfoil = readtable ('Names.xlsx', 'Sheet', 'Name Set 1', 'Range', 'E1:F79');
elseif namesetmat == 2
    namesfoil = readtable ('Names.xlsx', 'Sheet', 'Name Set 2', 'Range', 'E1:F79');
end
namesfoil = table2array(namesfoil);
namesfoil = string (namesfoil);
firstnamefoil = namesfoil (:,1);
lastnamefoil = namesfoil (:,2);
bothnamesfoil = strcat(firstnamefoil, {' '}, lastnamefoil);
bothnamesfoil = char(bothnamesfoil);
 
%% Keyboard Setup

KbName('UnifyKeyNames');
spaceKey = KbName('space');
escapeKey = KbName('Escape');
option1 = KbName ('1');
option2 = KbName ('2');
option3 = KbName ('3');

%% Storage

resultsMatrix = dlmread (fullFileName);

%% Experimental Loop

line1 = 'In this part, the faces will appear on-screen one at a time with 3 names.';
line2 = '\n\n Choose the name that belongs to the face.';
line3 = '\n\n Use the 1, 2 and 3 key to indicate choice for each option.';
line4 = '\n\n Images will appear on-screen automatically after choice is made.';
Screen ('TextSize', window, 35);
Screen ('TextFont', window, 'Times');
DrawFormattedText (window, [line1 line2 line3 line4],  'center', screenYpixels * 0.25, black);
line5 = 'Press Space To Continue Onto Faces.';
Screen ('TextSize', window, 35);
Screen ('TextFont', window, 'Times');
DrawFormattedText (window, [line5], 'center', screenYpixels * 0.80, black);
Screen('Flip', window);
KbStrokeWait;

% faceindicespractice = randperm (166, (trialnumbertotal - trialnumber));
rng ('shuffle');
indicesforcedchoice = randperm (78, 78);
malefoilnameindices = randperm (39,39);
femalefoilnameindices = randperm(39,39) + 39;

femaletrials = 0;
maletrials = 0;

rangef1 = [1:3];
rangef2 = [7:16];
rangef3 = [27:32];
rangef4 = [39:58];
rangefemale = [rangef1, rangef2, rangef3, rangef4]; 

rangem1 = [4:6];
rangem2 = [17:26];
rangem3 = [33:38]; 
rangem4 = [59:78];
rangemale = [rangem1, rangem2, rangem3, rangem4]; 
 
positions = [0.75 0.86 0.97];           
ordermatrix = zeros (78,3);  
orderposition = zeros(1,3);
   
for i = 1:78 
    ordermatrix (i,:) = positions(randperm(numel(positions),3));  
end
    
for trials = 1:trialnumber     
    respToBeMade = true; 
%     if trials < ((trialnumbertotal - trialnumber) + 1)
%         imageName = ['CFD' '- ' '(' num2str(faceindicespractice(trials)) ')' '.jpg'];
%         theImage = imread([imageFolderPractice imageName]);
%         [s1, s2, s3] = size(theImage); 
%         imageTexture = Screen ('MakeTexture', window, theImage); 
%         aspectRatio = s2/s1; 
%         imageHeights = screenYpixels/1.2;
%         imageWidths = imageHeights * aspectRatio;
%         theRect = [0 0 imageWidths imageHeights];
%         dstRects = CenterRectOnPointd (theRect, screenXpixels/2, screenYpixels/2);
%         Screen ('DrawTexture', window, imageTexture, [], dstRects);
%         Screen ('Flip', window); 
%         KbStrokeWait;       
%         Screen ('Close', imageTexture);
%     else
%         if trials == trialnumbertotal - trialnumber + 1
%             line6 = 'End Of Practice.';
%             Screen ('TextSize', window, 35);
%             Screen ('TextFont', window, 'Times');
%             DrawFormattedText (window, [line6], 'center', screenYpixels * 0.5, black);
%             line7 = 'Press Space To Continue Onto Experiment.';
%             Screen ('TextSize', window, 35);
%             Screen ('TextFont', window, 'Times');
%             DrawFormattedText (window, [line7], 'center', screenYpixels * 0.80, black);
%             Screen('Flip', window);
%             KbStrokeWait;  
%         end 
    if trials == trialnumber/2
        breaktext = 'REST! \n\n Press space when \n\n you are ready to continue';
        Screen ('TextSize', window, 60);
        Screen ('TextFont', window, 'Times');
        DrawFormattedText (window, [breaktext], 'center', 'center', black);
        Screen ('Flip', window);
        KbStrokeWait; 
    end 
    imageName = ['CFD-1 ' '(' num2str(indicesforcedchoice(trials)) ')' '.jpg'];
    theImage = imread([imageFolderTask imageName]);
    [s1, s2, s3] = size(theImage);
    imageTexture = Screen ('MakeTexture', window, theImage);
    aspectRatio = s2/s1; 
    imageHeights = screenYpixels/1.55; 
    imageWidths = imageHeights * aspectRatio;   
    theRect = [(screenXpixels/2 - imageWidths/2) 10 (screenXpixels/2 + imageWidths/2) (imageHeights + 10)];
%     dstRects = CenterRectOnPointd (theRect, screenXpixels/2,
%     screenYpixels/2);    \
    fullnamereal = bothnamesreal (indicesforcedchoice(trials),:); 
    fullnamereal = strtrim (fullnamereal);
    if sum(indicesforcedchoice (trials) == rangefemale) > 0 
        femaletrials = femaletrials + 1;
        fullnamefoil = bothnamesfoil(femalefoilnameindices(femaletrials),:);
        fullnamefoil = strtrim (fullnamefoil);
        lureindex = rangefemale(randperm(numel(rangefemale),1));
        while lureindex == indicesforcedchoice(trials)
            lureindex = rangefemale(randperm(numel(rangefemale),1)); 
        end
        fullnamelure = bothnamesreal (lureindex,:);
        fullnamelure = strtrim (fullnamelure); 
    elseif sum(indicesforcedchoice (trials) == rangemale) > 0 
        maletrials = maletrials + 1;   
        fullnamefoil = bothnamesfoil (malefoilnameindices (maletrials), :);
        fullnamefoil = strtrim (fullnamefoil); 
        lureindex = rangemale(randperm(numel(rangemale),1));
        while lureindex == indicesforcedchoice(trials)
            lureindex = rangemale(randperm(numel(rangemale),1));
        end
        fullnamelure = bothnamesreal (lureindex,:);
        fullnamelure = strtrim (fullnamelure);  
    end 
    while respToBeMade == true  
        Screen ('DrawTexture', window, imageTexture, [], theRect);        
        Screen ('TextSize', window, 60);     
        Screen ('TextFont', window, 'Arial'); 
        firstoption = find (ordermatrix(trials,:) == 0.75);
        orderposition (1,firstoption) = 1;
        secondoption = find (ordermatrix(trials,:) == 0.86);
        orderposition (1,secondoption) = 2;
        thirdoption = find (ordermatrix(trials,:) == 0.97);
        orderposition (1,thirdoption) = 3;
        DrawFormattedText (window, [num2str(orderposition(1,1)), '. ', fullnamereal],...
            'center', (screenYpixels * (ordermatrix(trials,1))), black);  
        DrawFormattedText (window, [num2str(orderposition(1,2)), '. ', fullnamefoil],...
            'center', (screenYpixels * (ordermatrix (trials,2))), black);
        DrawFormattedText (window, [num2str(orderposition(1,3)), '. ', fullnamelure],...
            'center', (screenYpixels * (ordermatrix(trials,3))), black);
        Screen ('Flip', window);      
        [keyIsDown, secs, keyCode] = KbCheck;       
        if keyCode(escapeKey)    
            ShowCursor;
            sca; 
            return  
        elseif keyCode (option1)
            forcedchoice = 1;
            respToBeMade = false; 
        elseif keyCode (option2)
            forcedchoice = 2;
            respToBeMade = false; 
        elseif keyCode (option3)
            forcedchoice = 3;
            respToBeMade = false;
        end 
    end
  %  resultsMatrix (indicesforcedchoice(trials), 6) = indicesforcedchoice (trials);
    resultsMatrix (indicesforcedchoice (trials), 9) = orderposition (1,1);  
    resultsMatrix (indicesforcedchoice(trials), 10) = forcedchoice;
    for frames = 1:isiTimeFrames -1 
        Screen('Flip', window); 
        Screen ('DrawDots', window, [xCenter; yCenter], 10, black, [], 2);
        Screen ('Flip', window);  
    end 
end
 
Screen ('TextSize', window, 80);
DrawFormattedText (window, 'Section Finished \n\n Press Any Key To Exit',...
    'center', 'center', black);
Screen ('Flip', window);
KbStrokeWait; 
sca;

%% Save Data Matrix 

dlmwrite (fullFileName, resultsMatrix);

resultsTable = array2table (resultsMatrix,'VariableNames', {'FaceNamePair', 'LikeabilityResponse', 'Primed', ...
'Recall', 'FOKRating', 'ResponseTimeTotal', 'ResponseTimeFOKJ', 'RestudyChoice',...
'ForcedChoiceCorrectResponse', 'ForcedChoiceResponse'});
fulltablename = fullfile (pFolder, 'participantresultstable.xlsx');
writetable(resultsTable, fulltablename); 
 