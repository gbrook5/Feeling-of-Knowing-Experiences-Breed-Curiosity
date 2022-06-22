% FOK-Restudy with Novelty Study

% Phase 0 - participant set-up and curiosity questionnaires

%% Participant Information and Folder Set-Up

rng ('shuffle');
namesetmat = randi (2);
namesetstr = mat2str(namesetmat); % assign participant to 1 of 2 face-name combos

checkPID = true;
while checkPID == true
    pID = input ('Participant ID: ', 's'); %input participant ID
    ssnID = input ('Session ID: ', 's'); % input session #
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
        ('/home/kohlerlab/Greg/FOK-Restudy + Novelty Study',...
        'Unproccessed Subject Data', pID, ['Data.', pID '.' ssnID '.' namesetstr '.mat']); % creates new subfolder for participant
    if exist(pFile, 'file')
        moveOn = input ('WARNING: Datafile already exists! Overwrite? (y/n) ', 's'); % warns you if that one is alread created
        if isempty (moveOn) || moveOn == 'n'
            checkPID = true;
        end
    end
end

pFolder = fullfile...
    ('/home/kohlerlab/Greg/FOK-Restudy + Novelty Study',...
    'Unproccessed Subject Data', pID);
if ~exist (pFolder)
    mkdir(pFolder);
end

Data.pID = pID;
Data.ssnID = ssnID;
Data.startTime = datestr(now);

save(pFile, 'Data');

%% Storage

resultsMatrix = nan(78, 11); 
newcol = (1:78)';
resultsMatrix = [newcol resultsMatrix];

questionnairematrix = nan (12,2);

%% Keyboard Setup

KbName('UnifyKeyNames');
spaceKey = KbName('space');
escapeKey = KbName('Escape');
never = KbName('1!');
sometimes = KbName ('2@');
often = KbName ('3#');
always = KbName ('4$');

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

ListenChar (2);

%% Timing Information

isiTimeSecs = 0.5; 
isiTimeFrames = round(isiTimeSecs / ifi);

%% Experimental Loop

line1 = 'In this part, you will rate,';
line2 = '\n\n on a scale from 1 (almost never) to 4 (almost always),';
line3 = '\n\n the degree to which you think various statements apply to you';
line4 = '\n\n The next prompt will appear after your answer is provided.';
Screen ('TextSize', window, 45);
Screen ('TextFont', window, 'Times');
DrawFormattedText (window, [line1 line2 line3 line4],  'center', screenYpixels * 0.20, black);
line5 = 'Press Space To Continue Onto Experiment.'; 
Screen ('TextSize', window, 75);
Screen ('TextFont', window, 'Times');
DrawFormattedText (window, [line5], 'center', screenYpixels * 0.90, black);
Screen('Flip', window);
KbStrokeWait;

for i = 1:22
    respToBeMade = true;
    while respToBeMade == true
        Screen ('TextSize', window, 65);
        Screen ('TextFont', window, 'Times');
        if i == 1
            DrawFormattedText (window, ['I enjoy exploring new ideas.'],...
                'center', screenYpixels * 0.35, black); 
        elseif i == 2
            DrawFormattedText (window, ['I find it fascinating to learn new information.'],...
                'center', screenYpixels * 0.35, black); 
        elseif i == 3
            DrawFormattedText (window, ['I enjoy learning about subjects \n that are unfamiliar to me.'],...
                'center', screenYpixels * 0.35, black); 
        elseif i == 4
            DrawFormattedText (window, ['I enjoy having discussions about abstract concepts.'], ...
                'center', screenYpixels * 0.35, black); 
        elseif i == 5
            DrawFormattedText (window, ['When I learn something new \n I like to find out more about it.'],...
                'center', screenYpixels * 0.35, black); 
        elseif i == 6
            DrawFormattedText (window,...
                ['I can spend hours on a single problem \n because I cannot rest without knowing the answer.'],...
                'center', screenYpixels * 0.35, black); 
        elseif i == 7
            DrawFormattedText (window, ['I will brood for a long time \n in order to solve a problem.'], ...
                'center', screenYpixels * 0.35, black); 
        elseif i == 8
            DrawFormattedText (window, ['Conceptual problems keep me awake \n and thinking about it.'],...
                'center', screenYpixels * 0.35, black); 
        elseif i == 9
            DrawFormattedText (window,...
                ['If I am frustrated that I cannot figure out a \n solution to a problem, I will work even harder.'],...
                'center', screenYpixels * 0.35, black);
        elseif i == 10
            DrawFormattedText (window, ['I will work like a fiend at problems \n that I feel must be solved.'],...
                'center', screenYpixels * 0.35, black);
        elseif i == 11
            DrawFormattedText (window, ['I like to discover new places to go.'],...
                'center', screenYpixels * 0.35, black);
        elseif i == 12
            DrawFormattedText (window, ['I like to travel to places \n I have never been to before.'],...
                'center', screenYpixels * 0.35, black);
        elseif i == 13
            DrawFormattedText (window, ['I like to listen to new or unusual kinds of music.'],...
                'center', screenYpixels * 0.35, black);
        elseif i == 14
            DrawFormattedText (window, ['I like to explore my surroundings.'],...
                'center', screenYpixels * 0.35, black);
        elseif i == 15
            DrawFormattedText (window, ['I like to try new or different foods.'],...
                'center', screenYpixels * 0.35, black);
        elseif i == 16
            DrawFormattedText (window, ['I like to visit art galleries or museums.'],...
                'center', screenYpixels * 0.35, black);
        elseif i == 17
            DrawFormattedText (window, ['When I smell something new, \n I usually try find out what it is.'],...
                'center', screenYpixels * 0.35, black);
        elseif i == 18
            DrawFormattedText (window,...
                ['When I hear a strange sound, \n I usually try to find out what caused it.'],...
                'center', screenYpixels * 0.35, black);
        elseif i == 19
            DrawFormattedText (window, ['When I see a new fabric, \n I like to touch and feel it.'],...
                'center', screenYpixels * 0.35, black);
        elseif i == 20
            DrawFormattedText (window, ['When I hear something, \n I want to see what it is.'],...
                'center', screenYpixels * 0.35, black);
        elseif i == 21
            DrawFormattedText (window, ['When I hear a musical instrument being played, \n I like to see it.'],...
                'center', screenYpixels * 0.35, black);
        elseif i == 22
            DrawFormattedText (window,...
                ['When I see a vocal group perform I try to \n associate the different voice types to each singer.'],...
                'center', screenYpixels * 0.35, black);
        end
        Screen ('TextSize', window, 45);
        Screen ('TextFont', window, 'Times');
        DrawFormattedText (window, ['1 = almost never    2 = sometimes    3 = often    4 = almost always'],...
            'center', screenYpixels * 0.65, black);
        Screen ('Flip', window); 
        [keyIsDown,secs,keyCode] = KbCheck;
        if keyCode (escapeKey)
            sca;
            return
        elseif keyCode(never)
            qresponse = 1;
            respToBeMade = false;
        elseif keyCode(sometimes)
            qresponse = 2;
            respToBeMade = false;
        elseif keyCode (often)
            qresponse = 3;
            respToBeMade = false;
        elseif keyCode (always)
            qresponse = 4;
            respToBeMade = false;
        end
    end
    if i < 11
        questionnairematrix (i,1) = qresponse;
    elseif i >= 11
        questionnairematrix (i-10,2) = qresponse;
    end
    for frames = 1:isiTimeFrames -1
        Screen('Flip', window);
        Screen ('DrawDots', window, [xCenter; yCenter], 10, black, [], 2);
        Screen ('Flip', window);
    end
end
 
Screen ('TextSize', window, 100);
DrawFormattedText (window, 'Section Finished \n\n Press Any Key To Exit',...
    'center', 'center', black);
Screen ('Flip', window);
KbStrokeWait; 
sca;

%% 

fullFileName = fullfile (pFolder, 'participantresults.txt');
dlmwrite (fullFileName, resultsMatrix);

fullFileNameQ = fullfile (pFolder, 'participantquestionnaire.txt');
dlmwrite (fullFileNameQ, questionnairematrix);

questionnaireTable = array2table (questionnairematrix,'VariableNames', {'ECScale', 'PCScale'});
fulltablename = fullfile (pFolder, 'participantquestionnairetable.xlsx');
writetable(questionnaireTable, fulltablename); 

ListenChar (0);
    