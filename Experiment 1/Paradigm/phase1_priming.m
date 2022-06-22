% FOK-RESTUDY BEHAVIOURAL PARADIGM

% Phase 1 - Priming Phase 

%% Participant Information and Folder Set-Up

rng ('shuffle');
namesetmat = randi (2);
namesetstr = mat2str(namesetmat);

checkPID = true;
while checkPID == true
    pID = input ('Participant ID: ', 's');
    ssnID = input ('Session ID: ', 's');
    if isempty(pID)
        pID = '999';
    end
    if isempty (ssnID)
        if isempty(varargin) || ~any(strcmp(varagin, 'DefaultSession'))
            ssnID = '1';
        else
            index = find(strcmp(varagin, 'DefaultSession'));
            ssnID = varagin{index + 1};
        end
    end
    fprintf ('\n Saving data as Data.%s.%s.%s.mat\n\n', pID, ssnID, namesetstr)
    checkPID = false;
    pFile = fullfile...
        ('C:/Users/gabro/Documents/Graduate Studies/Reserach/FOK-Restudy Behavioural Study/FOK-Restudy Experimental Paradigm',...
        'SubjectData', pID, ['Data.', pID '.' ssnID '.' namesetstr '.mat']);
    if exist(pFile, 'file')
        moveOn = input ('WARNING: Datafile already exists! Overwrite? (y/n) ', 's');
        if isempty (moveOn) || moveOn == 'n'
            checkPID = true;
        end
    end
end

pFolder = fullfile...
    ('C:/Users/gabro/Documents/Graduate Studies/Reserach/FOK-Restudy Behavioural Study/FOK-Restudy Experimental Paradigm',...
    'SubjectData', pID);
if ~exist (pFolder)
    mkdir(pFolder);
end

Data.pID = pID;
Data.ssnID = ssnID;
Data.startTime = datestr(now);

save(pFile, 'Data');

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
%     'Graduate Studies' filesep 'Thesis' filesep 'FOK-Restudy Experimental Paradigm' filesep 'All Faces' filesep]; 
%   
imageFolderPriming = ['C:' filesep 'Users' filesep 'gabro' filesep 'Documents' filesep...
    'Graduate Studies' filesep 'Research' filesep 'FOK-Restudy Behavioural Study' filesep ...
    'FOK-Restudy Experimental Paradigm' filesep 'Priming Faces' filesep];
trialnumber = 78;  
trialnumbertotal = 83;  

%% Keyboard Setup

KbName('UnifyKeyNames');
spaceKey = KbName('space');
escapeKey = KbName('Escape');
hard_no = KbName ('1');
no = KbName ('2');
neutral = KbName ('3');
yes = KbName ('4');
definitely = KbName ('5');
% RestrictKeysForKbCheck ([10 66 84 85 88 89 90 112 117]);

%% Storage

resultsMatrix = nan(trialnumber, 9); 
newcol = (1:78)';
resultsMatrix = [newcol resultsMatrix];

%% Experimental Loop

line1 = 'In this part, faces will appear on-screen one at a time.';
line2 = '\n\n Please provide a rating on how likeable the person appears';
line3 = '\n\n from 1 (highly unlikeable) to 5 (highly likeable).';
line4 = '\n\n After your judgement is provided the next face will appear.';
Screen ('TextSize', window, 35);
Screen ('TextFont', window, 'Times');
DrawFormattedText (window, [line1 line2 line3 line4],  'center', screenYpixels * 0.25, black);
line5 = 'Press Space To Continue Onto Faces.';
Screen ('TextSize', window, 35);
Screen ('TextFont', window, 'Times');
DrawFormattedText (window, [line5], 'center', screenYpixels * 0.80, black);
Screen('Flip', window);
KbStrokeWait;
 
rng('shuffle');
faceindicespractice = randperm (24, (trialnumbertotal - trialnumber));
faceindicespriming = randperm (78, 78);
primetrials = 1; 
realtrial = 1;
             
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
%         KbStrokeWait;       
%         Screen ('Close', imageTexture);
%     end
    if trials > (trialnumbertotal - trialnumber +1)
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
        imageName = ['CFD-1 ' '(' num2str(faceindicespriming(realtrial)) ')' '.jpg'];
        theImage = imread([imageFolderPriming imageName]);
        [s1, s2, s3] = size(theImage); 
        imageTexture = Screen ('MakeTexture', window, theImage);
        aspectRatio = s2/s1;        
        imageHeights = screenYpixels/1.2;
        imageWidths = imageHeights * aspectRatio;
        theRect = [0 0 imageWidths imageHeights];
        dstRects = CenterRectOnPointd (theRect, screenXpixels/2, screenYpixels/2);
        while respToBeMade == true      
            Screen ('DrawTexture', window, imageTexture, [], dstRects);
            Screen ('Flip', window);
            [keyIsDown,secs,keyCode] = KbCheck;
            if keyCode (escapeKey)
                ShowCursor;
                sca;        
                return
            elseif keyCode (hard_no)
                response = 1;       
                respToBeMade = false;
            elseif keyCode (no)
                response = 2;
                respToBeMade = false;
            elseif keyCode (neutral)
                response = 3;
                respToBeMade = false;
            elseif keyCode (yes)
                response = 4;
                respToBeMade = false;
            elseif keyCode (definitely)
                response = 5;
                respToBeMade = false;
            end
        end   
        if faceindicespriming (realtrial) < 27
%             resultsMatrix (primetrials, 1) = faceindicespriming(primetrials);
            resultsMatrix (faceindicespriming(realtrial), 2) = response;        
            primetrials = primetrials + 1;    
        end              
        realtrial = realtrial + 1;      
        Screen('Close', [imageTexture]);
        for frames = 1:isiTimeFrames -1
            Screen('Flip', window); 
            Screen ('DrawDots', window, [xCenter; yCenter], 10, black, [], 2);
            Screen ('Flip', window);  
        end
    end                
end

Screen ('TextSize', window, 80);
DrawFormattedText (window, 'Section Finished \n\n Press Any Key To Exit',...
    'center', 'center', black);
Screen ('Flip', window);
KbStrokeWait; 
sca;

resultsMatrix (27:end,2) = 0;

%% Save Data Matrix

fullFileName = fullfile (pFolder, 'participantresults.txt');
dlmwrite(fullFileName, resultsMatrix);        
 