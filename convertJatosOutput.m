function convertJatosOutput
[file, path] = uigetfile('*.txt');
if isequal(file, 0) || isequal(path, 0)
    return
end
lines = readlines([path, filesep, file]);
lines(lines.strlength == 0) = [];
tasks = arrayfun(@(s)jsondecode(s), lines, 'UniformOutput', false);
for i = 1:numel(tasks)
    trials = tasks{i};
    taskName = '?';
    participantID = '?';
    outputTable = table();
    try
        for j = 1:numel(trials)
            if isfield(trials{j}, "response") && isfield(trials{j}.response, "participant_id")
                participantID = trials{j}.response.participant_id;
            end
            if isfield(trials{j}, "simon")
                if isfield(trials{j}, "response_key")
                    taskName = 'squares';
                elseif isfield(trials{j}, "block")
                    taskName = 'colors';
                else
                    taskName = 'practice';
                end
                trialTable = struct2table(convert(trials{j}), 'AsArray', true);
                participant_id = repmat(string(participantID), height(trialTable), 1);
                trial = repmat(j - 2, height(trialTable), 1);
                outputTable = [outputTable; addvars(trialTable, participant_id, trial)];
            end
        end
        outputFile = ['simon-', taskName, '-task_id_', participantID, '.csv'];
        if isfile(outputFile)
            error([outputFile, ' already exists.']);
        end
        writetable(outputTable, outputFile);
    catch ME
        warning(['Failed to write ', taskName, ' task for participant ', participantID, '.']);
        disp(ME.message);
    end
end
end