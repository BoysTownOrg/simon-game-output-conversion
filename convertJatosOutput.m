function convertJatosOutput
[file, path] = uigetfile('*.txt');
if isequal(file, 0) || isequal(path, 0)
    return
end
lines = readlines([path, filesep, file]);
lines(lines.strlength == 0) = [];
json = arrayfun(@(s)jsondecode(s), lines, 'UniformOutput', false);
for task = 1:numel(json)
    trials = json{task};
    try
        assert(numel(trials) > 2, "Task does not have more than two trials.");
        if isfield(trials{3}, "response_key")
            taskName = 'squares';
        elseif isfield(trials{3}, "block")
            taskName = 'colors';
        else
            taskName = 'practice';
        end
        assert(isfield(trials{1}, "response") && isfield(trials{1}.response, "participant_id"), "Task does not have participant ID");
        participantID = trials{1}.response.participant_id;
        outputTable = table();
        for i = 3:numel(trials)
            if isfield(trials{i}, "simon")
                trialTable = struct2table(convert(trials{i}));
                participant_id = repmat(string(participantID), height(trialTable), 1);
                trial = repmat(i - 2, height(trialTable), 1);
                outputTable = [outputTable; addvars(trialTable, participant_id, trial)];
            end
        end
        outputFile = ['simon-', taskName, '-task_id_', participantID, '.csv'];
        if isfile(outputFile)
            error([outputFile, ' already exists.']);
        end
        writetable(outputTable, outputFile);
    catch ME
        warning(['Failed to write task #', num2str(task), '.']);
        warning(ME.message);
    end
end
end