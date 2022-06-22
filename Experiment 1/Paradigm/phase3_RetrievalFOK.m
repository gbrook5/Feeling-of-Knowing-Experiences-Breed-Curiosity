% FOK-RESTUDY BEHAVIOURAL PARADIGM

% Phase 3 - Recall/FOK Phase 

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
    'Graduate Studies' filesep 'Research' filesep 'FOK-Restudy Behavioural Study' filesep ...
    'FOK-Restudy Experimental Paradigm' filesep 'Encoding Faces' filesep]; % 1st 26 faces in directory = old, randomly presented
trialnumber = 78;  
trialnumbertotal = 83;  

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

line1 = 'Next, the previosuly studied faces will appear on-screen one at a time for 3 seconds.';
line2 = '\n\n Please use this time to try and recall the persons name.';
line3 = '\n\n After, you will be directed to indicate \n\n whether you were able to remember the name or not.';
line4 = '\n\n Indicate this using either the Up Arrow for yes or the Down Arrow for no.';
line5 = '\n\n After this you will be asked to judge how likely it is, \n\n from 1 to 5, you would correctly recognize the name';
line6 = '\n\n Please ensure that you make use of the whole scale for this rating.';
Screen ('TextSize', window, 30);
Screen ('TextFont', window, 'Times');
DrawFormattedText (window, [line1 line2 line3 line4 line5 line6],  'center', screenYpixels * 0.20, black);
line7 = 'Press Space To Continue Onto Faces.';
Screen ('TextSize', window, 35);
Screen ('TextFont', window, 'Times');
DrawFormattedText (window, [line7], 'center', screenYpixels * 0.90, black);
Screen('Flip', window);
KbStrokeWait;

rng ('shuffle');
faceindicespractice = randperm (24, (trialnumbertotal - trialnumber));
faceindicesrecall = randperm (78, 78);
recalltrials = 1;
          
for trials = 1:trialnumbertotal      
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
    if trials > (trialnumbertotal - trialnumber) 
%         if trials == trialnumbertotal - trialnumber + 1
%             line6 = 'End Of Practice.';
%             Screen ('TextSize', window, 60);
%             Screen ('TextFont', window, 'Times');
%             DrawFormattedText (window, [line6], 'center', screenYpixels * 0.5, black);
%             line7 = 'Press Space To Continue Onto Experiment.';
%             Screen ('TextSize', window, 60);
%             Screen ('TextFont', window, 'Times');
%             DrawFormattedText (window, [line7], 'center', screenYpixels * 0.80, black);
%             Screen('Flip', window);
%             KbStrokeWait;  
%         end     
    if trials == (trialnumbertotal-trialnumber) + (trialnumber/2)
        breaktext = 'REST! \n\n Press space when \n\n you are ready to continue';
        Screen ('TextSize', window, 60);
        Screen ('TextFont', window, 'Times');
        DrawFormattedText (window, [breaktext], 'center', 'center', black);
        Screen ('Flip', window);
        KbStrokeWait;
    end 
        imageName = ['CFD-1 ' '(' num2str(faceindicesrecall(recalltrials)) ')' '.jpg'];
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
        recallquestion = 'Were you able to remember the persons name?';
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
        if faceindicesrecall(recalltrials) < 27
            primevsnot = 1;
        else
            primevsnot = 0;            
        end
        tFOK = tEnd - tMiddle;
        tAll = tEnd - tStart;
     %   resultsMatrix (faceindicesrecall(recalltrials   , )) = faceindicesrecall(recalltrials);
        resultsMatrix (faceindicesrecall(recalltrials), 3) = primevsnot;
        resultsMatrix (faceindicesrecall(recalltrials), 4) = recallresponse;
        resultsMatrix (faceindicesrecall(recalltrials), 5) = FOKresponse;
        resultsMatrix (faceindicesrecall(recalltrials), 6) = tAll;
        resultsMatrix (faceindicesrecall(recalltrials), 7) = tFOK; 
        recalltrials = recalltrials + 1;                                          
    end                 
end

Screen ('TextSize', window, 80);
DrawFormattedText (window, 'Section Finished \n\n Press Any Key To Exit',...
    'center', 'center', black);
Screen ('Flip', window);
KbStrokeWait; 
sca;     
        
%% Save Matrix

dlmwrite (fullFileName, resultsMatrix); 
 