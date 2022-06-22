% FOK-Restudy with Novelty Paradigm

% Phase 3 - Restudy Choices

% if we switch to 50% restudy choices (39):

% change instructions to read "one half (39)"
% change to choicesleft = (num2str (39 (26) - restudyselections))
% change if restudyselection >= 26 to 39

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
 
imageFolderTask = ['C:', filesep 'Users' filesep 'gabro' filesep 'Documents' filesep 'Graduate Studies' filesep...
    'Research' filesep 'Novelty + FOK Behavioural' filesep 'Experimental Paradigm' filesep ...
    'Encoding + Novel Faces' filesep];  

%% Names

if namesetmat == 1
    names = readtable ('Names.xlsx', 'Sheet', 'Name Set 1', 'Range', 'A1:B79');
elseif namesetmat == 2
    names = readtable ('Names.xlsx', 'Sheet', 'Name Set 2', 'Range', 'A1:B79');
end
names = table2array (names);  
names = string(names);
firstname = names(:,1);
lastname = names (:,2);
bothnames = strcat(firstname, {' '},lastname);
bothnames = char(bothnames);

%% Keyboard Setup

KbName('UnifyKeyNames');
spaceKey = KbName('space');
escapeKey = KbName('Escape');
yeschoice = KbName ('UpArrow');
nochoice = KbName ('DownArrow');

%% Storage

resultsMatrix = dlmread (fullFileName);

%% Experimental Loop

line1 = 'Now you will get the chance to see some of the names again.';
line2 = '\n\n You will be able to choose up to one half (39) of the faces to restudy the name.';
line3 = '\n\n You will move through each face and will say either yes I wish to see their name,'; 
line4 = '\n\n using the Up Arrow, in which case the face and name will appear together again on screen';
line5 = '\n\n or no I do not want to, using the Down Arrow, moving you right to the next face.';
line6 = '\n\n A countdown with how many yes chocies you have left will be in the bottom corner';
line7 = '\n\n and you will get a break halfway through.';
Screen ('TextSize', window, 30);
Screen ('TextFont', window, 'Times');
DrawFormattedText (window, [line1 line2 line3 line4 line5 line6 line7],  'center', screenYpixels * 0.10, black);
line5 = 'Press Space To Continue Onto Experiment.';
Screen ('TextSize', window, 35); 
Screen ('TextFont', window, 'Times');
DrawFormattedText (window, [line5], 'center', screenYpixels * 0.93, black);
Screen('Flip', window);
KbStrokeWait;
 
% faceindicespractice = randperm (166, (trialnumbertotal - trialnumber));
rng ('shuffle');
indicesrestudy = randperm (78, 78);

% encodemaxchocies
restudyselection = 0;

for trials = 1:length(indicesrestudy)     
    respToBeMade = true;
    choicesleft = num2str(39 - restudyselection); 
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
    if trials == (length(indicesrestudy))/2
        breaktext = 'REST! \n\n Press space when \n\n you are ready to continue';
        Screen ('TextSize', window, 60);
        Screen ('TextFont', window, 'Times');
        DrawFormattedText (window, [breaktext], 'center', 'center', black);
        Screen ('Flip', window);
        KbStrokeWait;
    end
    imageName = ['CFD-1 ' '(' num2str(indicesrestudy(trials)) ')' '.jpg'];
    theImage = imread([imageFolderTask imageName]);
    [s1, s2, s3] = size(theImage);
    imageTexture = Screen ('MakeTexture', window, theImage);
    aspectRatio = s2/s1; 
    imageHeights = screenYpixels/1.4; 
    imageWidths = imageHeights * aspectRatio;  
    theRect = [(screenXpixels/2 - imageWidths/2) 150 (screenXpixels/2 + imageWidths/2) (imageHeights + 150)];
%     dstRects = CenterRectOnPointd (theRect, screenXpixels/2,
%     screenYpixels/2);  
    question = 'Would you like to see their name again (Yes = Up, Down = No)?';
  %  question2 = '\n\n Indicate yes with the Up Arrow and no with the Down Arrow.'
    while respToBeMade == true 
        if restudyselection >= 39
            Screen ('TextSize', window, 50);
            Screen ('TextFont', window, 'Times');
            Screen ('DrawTexture', window, imageTexture, [], theRect); 
            DrawFormattedText (window, [question], 'center', screenYpixels *0.1, black);
            Screen ('TextSize', window, 30);
            DrawFormattedText (window, ['\n\n Out of restudy selections! Must select no!'],...
                'center', screenYpixels * 0.1, black);
            Screen ('TextSize', window, 30);  
            DrawFormattedText (window, ['Choices Left:  ', choicesleft], screenXpixels * 0.80, screenYpixels * 0.9, black); 
            Screen ('Flip', window); 
            [keyIsDown, secs, keyCode] = KbCheck;   
            if keyCode (escapeKey)
                ShowCursor;
                sca;
                return
            elseif keyCode (nochoice)
                restudychoice = 0;
                respToBeMade = false;
            end
        else
            Screen ('TextSize', window, 50);
            Screen ('TextFont', window, 'Times');
            Screen ('DrawTexture', window, imageTexture, [], theRect);
            DrawFormattedText (window, [question], 'center', screenYpixels * 0.12, black);
            Screen ('TextSize', window, 30);
            DrawFormattedText (window, ['Choices Left: ', choicesleft], screenXpixels * 0.80, screenYpixels * 0.9, black);
            Screen('Flip', window);
            [keyIsDown, secs, keyCode] = KbCheck;  
            if keyCode (escapeKey)
                ShowCursor;
                sca;
                return  
            elseif keyCode (yeschoice)
                restudychoice = 1;
                imageName = ['CFD-1 ' '(' num2str(indicesrestudy(trials)) ')' '.jpg'];
                theImage = imread([imageFolderTask imageName]);
                [s1, s2, s3] = size(theImage);
                imageTexture = Screen ('MakeTexture', window, theImage);
                aspectRatio = s2/s1;
                imageHeights = screenYpixels/1.4;
                imageWidths = imageHeights * aspectRatio;
                theRect = [(screenXpixels/2 - imageWidths/2) 40 (screenXpixels/2 + imageWidths/2) (imageHeights + 40)];
                fullname = bothnames (indicesrestudy(trials),:);
                fullname = strtrim (fullname);
                Screen ('DrawTexture', window, imageTexture, [], theRect);
                Screen ('TextSize', window, 90);
                Screen ('TextFont', window, 'Arial');
                DrawFormattedText (window, [fullname], 'center', screenYpixels * 0.93, black);
                Screen ('Flip', window);
                if keyCode(escapeKey)
                    ShowCursor;
                    sca;
                    return
                end
                WaitSecs(3); 
                respToBeMade = false;
                restudyselection = restudyselection + 1;
            elseif keyCode (nochoice) 
                restudychoice = 0;
                respToBeMade = false;
            end
        end 
    end
 %   resultsMatrix (indicesrestudy(trials, 1)) = indicesrestudy(trials);
    resultsMatrix (indicesrestudy(trials), 7) = restudychoice;
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
 
%% Save Data

dlmwrite (fullFileName , resultsMatrix);