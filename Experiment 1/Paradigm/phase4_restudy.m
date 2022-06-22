% FOK- Restudy Paradigm

% Phase 4- Restudy Choice

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
    'Research' filesep 'FOK-Restudy Behavioural Study' filesep 'FOK-Restudy Experimental Paradigm' filesep...
    'Encoding Faces' filesep];
trialnumber = 78;  
% trialnumbertotal = 83;  

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

line1 = 'Once again, you are going to be presented \n\n with the faces you memorized.';
line2 = '\n\n You will be able to choose one half (39) \n\n of the faces to see the name belonging to the person again.';
line3 = '\n\n To study the face and name again, \n\n place the Up Arrow to indicate yes and the Down Arrow for no.';
line4 = '\n\n If you choose yes, \n\n the face and name will appear on the screen for a short time.';
line5 = '\n\n The face and name will then disappear \n\n and the next face will automatically appear asking for your choice.';
Screen ('TextSize', window, 30);
Screen ('TextFont', window, 'Times');
DrawFormattedText (window, [line1 line2 line3 line4 line5],  'center', screenYpixels * 0.10, black);
line5 = 'Press Space To Continue Onto Faces.';
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

for trials = 1:trialnumber     
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
    if trials == trialnumber/2
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
    question = 'Would you like to see their name again?';
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
    resultsMatrix (indicesrestudy(trials), 8) = restudychoice;
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