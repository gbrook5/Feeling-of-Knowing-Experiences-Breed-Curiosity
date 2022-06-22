  % FOK-RESTUDY BEHAVIOURAL PARADIGM
  
% Phase 2 - Encoding Phase 

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

% imageFolderPractice = ['C:' filesep 'Users' filesep 'gabro' filesep 'Documents' filesep...
%     'Graduate Studies' filesep 'Thesis' filesep 'FOK-Restudy Experimental Paradigm' filesep...
%     'Practice' filesep]; 
 
imageFolderTask = ['C:' filesep 'Users' filesep 'gabro' filesep 'Documents' filesep...
    'Graduate Studies' filesep 'Research' filesep 'FOK-Restudy Behavioural Study' filesep ...
    'FOK-Restudy Experimental Paradigm' filesep 'Encoding Faces' filesep]; 
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

%% Storage

% resultsMatrix = nan(trialnumber, 2); 
% 
% resultsDir = [filesep 'home' filesep 'gbrooks' filesep 'Documents' filesep...
%     'Experimental Paradigm'];
% if exist(resultsDir, 'dir') <1
%     mkdir(resultsDir);
% end

%% Experimental Loop

line1 = 'In this part, a series of faces will appear on-screen one at a time.';
line2 = '\n\n Each face will also have a name appearing beneath it.';
line3 = '\n\n Please remember the name that goes with each face.';
line4 = '\n\n Images will appear on-screen automatically.';
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
indicesencode = randperm (78, 78);

% encodetrials = 1; 
          
for trials = 1:trialnumber     
%     respToBeMade = true;
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
    imageName = ['CFD-1 ' '(' num2str(indicesencode(trials)) ')' '.jpg'];
    theImage = imread([imageFolderTask imageName]);
    [s1, s2, s3] = size(theImage);
    imageTexture = Screen ('MakeTexture', window, theImage);
    aspectRatio = s2/s1; 
    imageHeights = screenYpixels/1.4;
    imageWidths = imageHeights * aspectRatio;   
    theRect = [(screenXpixels/2 - imageWidths/2) 40 (screenXpixels/2 + imageWidths/2) (imageHeights + 40)];
%     dstRects = CenterRectOnPointd (theRect, screenXpixels/2,
%     screenYpixels/2);    \
    fullname = bothnames (indicesencode(trials),:); 
    fullname = strtrim (fullname); 
    Screen ('DrawTexture', window, imageTexture, [], theRect);       
    Screen ('TextSize', window, 90);    
    Screen ('TextFont', window, 'Arial');    
    DrawFormattedText (window, [fullname], 'center', screenYpixels * 0.93, black);   
    Screen ('Flip', window);  
    [keyIsDown, secs, keyCode] = KbCheck;     
    if keyCode(escapeKey)   
        ShowCursor;
        sca; 
        return
    end
    WaitSecs(3); 
    for frames = 1:isiTimeFrames -1
        Screen('Flip', window); 
        Screen ('DrawDots', window, [xCenter; yCenter], 10, black, [], 2);
        Screen ('Flip', window);  
    end 
end
 
Screen('TextSize', window, 80);
DrawFormattedText (window, 'Section Finished \n\n Press Any Key To Exit',...
    'center', 'center', black);
Screen ('Flip', window);
KbStrokeWait; 
sca;
 