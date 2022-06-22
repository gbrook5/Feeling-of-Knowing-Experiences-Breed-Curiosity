% FOK-RESTUDY WITH NOVELTY BEHAVIOURAL PARADIGM

% Phase 2 - Recall/FOK Phase with Novel Faces

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
waitframes = 1;

%imageSecs = 3;
%imageFrames = round(imageSecs/ifi);

%% Images

%imageFolderPractice = ['C:' filesep 'Users' filesep 'gabro' filesep 'Documents' filesep...
 %   'Graduate Studies' filesep 'Thesis' filesep 'FOK-Restudy Experimental Paradigm' 'All Faces' filesep]; 
 
imageFolderTask = ['C:' filesep 'Users' filesep 'gabro' filesep 'Documents' filesep...
    'Graduate Studies' filesep 'Research' filesep 'Novelty + FOK Behavioural' filesep ...
    'Experimental Paradigm' filesep 'Encoding + Novel Faces' filesep];

%% Keyboard Setup

KbName('UnifyKeyNames');
spaceKey = KbName('space');
escapeKey = KbName('Escape');
remembered = KbName('UpArrow');
failedtorecall = KbName('DownArrow');
noFOK = KbName('1');
littleFOK = KbName ('2');
neutralFOK = KbName ('3');
FOK = KbName ('4');
highFOK = KbName ('5');

%% Storage

resultsMatrix = dlmread (fullFileName);

%% Experimental Loop

line1 = 'Next, faces will appear on the screen for a short time.';
line2 = '\n\n Use this time to try and recall the full name of that person.';
line3 = '\n\n After, you will be directed to indicate \n\n whether you were able to remember the whole name or not.';
line4 = '\n\n Indicate this truthfully using either the Up Arrow for yes or the Down Arrow for no.';
line5 = '\n\n After this you will be asked to judge how likely it is, \n\n from 1 to 5, you would correctly recognize the name';
line6 = '\n\n Please try and distribute your responses across the entire 1 to 5 scale and keep in mind';
line7 = '\n\n that these ratings are about whether you think you could recognize the name and not about whether';
line8 = '\n\n you can recall it right now. The experiment will proceed once these answeres are provided.';
Screen ('TextSize', window, 30);
Screen ('TextFont', window, 'Times');
DrawFormattedText (window, [line1 line2 line3 line4 line5 line6 line7 line8],  'center', screenYpixels * 0.20, black);
line9 = 'Press Space To Continue Onto Experiment.';
Screen ('TextSize', window, 35);
Screen ('TextFont', window, 'Times');
DrawFormattedText (window, [line9], 'center', screenYpixels * 0.90, black);
Screen('Flip', window);
KbStrokeWait;

rng ('shuffle');
indicesrecall = randperm (78, 78);
recalltrials = 1;

for trials = 1:length(indicesrecall)
    respToBeMade = true;
    %     if trials < ((trialnumbertotal - trialnumber) + 1)
    %         imageName = ['CFD-1 ' '(' num2str(faceindicespractice(trials)) ')' '.jpg'];
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
    %         WaitSecs(3);
    %         Screen('Close', imageTexture);
    %         recallquestion = 'Were you able to remember the persons name?';
    %         recallquestion2 = '\n\n Use the Up Arrow to indicate yes and the Down Arrow for no.';
    %         Screen ('TextSize', window, 35);
    %         Screen ('TextFont', window, 'Times');
    %         DrawFormattedText (window, [recallquestion recallquestion2], 'center', screenYpixels * 0.50, black);
    %         Screen('Flip', window);
    %         KbStrokeWait;
    %         FOKquestion = 'How likely is it that would correctly recognize their name if given 3 choices?';
    %         FOKquestion2 = '\n\n Use a 1 to 5 scale, where 1 = very unlikely and 5 = very likely';
    %         Screen ('TextSize', window, 35);
    %         Screen ('TextFont', window, 'Times');
    %         DrawFormattedText (window, [FOKquestion FOKquestion2], 'center', screenYpixels * 0.50, black);
    %         Screen('Flip', window);
    %         KbStrokeWait;
    %     end
    if trials == (length(indicesrecall))/2
        breaktext = 'REST! \n\n Press space when \n\n you are ready to continue';
        Screen ('TextSize', window, 60);
        Screen ('TextFont', window, 'Times');
        DrawFormattedText (window, [breaktext], 'center', 'center', black);
        Screen ('Flip', window);
        KbStrokeWait;
    end
    imageName = ['CFD-1 ' '(' num2str(indicesrecall(recalltrials)) ')' '.jpg'];
    theImage = imread([imageFolderTask imageName]);
    [s1, s2, s3] = size(theImage);
    imageTexture = Screen ('MakeTexture', window, theImage);
    aspectRatio = s2/s1;
    imageHeights = screenYpixels/1.2;
    imageWidths = imageHeights * aspectRatio;
    theRect = [0 0 imageWidths imageHeights];
    dstRects = CenterRectOnPointd (theRect, screenXpixels/2, screenYpixels/2);
    Screen ('DrawTexture', window, imageTexture, [], dstRects);
    Screen ('Flip', window);
    WaitSecs(3);
    recallquestion = 'Were you able to remember the persons full name?';
    recallquestion2 = '\n\n Use the Up Arrow to indicate yes and the Down Arrow for no.';
    Screen ('TextSize', window, 35);
    Screen ('TextFont', window, 'Times');
    tStart = GetSecs;
    while respToBeMade == true
        DrawFormattedText (window, [recallquestion recallquestion2],  'center', 'center', black);
        Screen('Flip', window);
        [keyIsDown,secs,keyCode] = KbCheck;
        if keyCode (escapeKey)
            sca;
            return
        elseif keyCode(remembered)
            recallresponse = 1;
            respToBeMade = false;
        elseif keyCode(failedtorecall)
            recallresponse = 0;
            respToBeMade = false;
        end
    end
    tMiddle = GetSecs;
    respToBeMade = true;
    FOKquestion = 'How likely is it that you would correctly recognize their name?';
    FOKquestion2 = '\n\n Use a 1 to 5 scale, where 1 = very unlikely and 5 = very likely';
    Screen ('TextSize', window, 35);
    Screen ('TextFont', window, 'Times');
    while respToBeMade == true
        DrawFormattedText (window, [FOKquestion FOKquestion2],  'center', 'center' , black);
        Screen('Flip', window);
        [keyIsDown,secs,keyCode] = KbCheck;
        if keyCode (escapeKey)
            sca;
            return
        elseif keyCode(noFOK)
            FOKresponse = 1;
            respToBeMade = false;
        elseif keyCode(littleFOK)
            FOKresponse = 2;
            respToBeMade = false;
        elseif keyCode (neutralFOK)
            FOKresponse = 3;
            respToBeMade = false;
        elseif keyCode (FOK)
            FOKresponse = 4;
            respToBeMade = false;
        elseif keyCode (highFOK)
            FOKresponse = 5;
            respToBeMade = false;
        end
    end
    tEnd = GetSecs;
    if indicesrecall(recalltrials) < 53
        oldvsnew = 1;
    else
        oldvsnew = 0;
    end
    tFOK = tEnd - tMiddle;
    tAll = tEnd - tStart;
    %   resultsMatrix (faceindicesrecall(recalltrials   , )) = faceindicesrecall(recalltrials);
    resultsMatrix (indicesrecall(recalltrials), 2) = oldvsnew;
    resultsMatrix (indicesrecall(recalltrials), 3) = recallresponse;
    resultsMatrix (indicesrecall(recalltrials), 4) = FOKresponse;
    resultsMatrix (indicesrecall(recalltrials), 5) = tAll;
    resultsMatrix (indicesrecall(recalltrials), 6) = tFOK;
    recalltrials = recalltrials + 1;
end

Screen ('TextSize', window, 80);
DrawFormattedText (window, 'Section Finished \n\n Press Any Key To Exit',...
    'center', 'center', black);
Screen ('Flip', window);
KbStrokeWait; 
sca;     
        
%% Save Matrix

dlmwrite (fullFileName, resultsMatrix); 
 