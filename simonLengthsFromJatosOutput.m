function simonLengthsFromJatosOutput
[file, path] = uigetfile('*.txt');
if isequal(file, 0) || isequal(path, 0)
    return
end
lines = readlines([path, filesep, file]);
lines(lines.strlength == 0) = [];
tasks = arrayfun(@(s)jsondecode(s), lines, 'UniformOutput', false);
writer = SimonLengthsCsvWriter('simon-lengths.csv');
for i = 1:numel(tasks)
    trials = tasks{i};
    participantID = '?';
    taskName = '?';
    lengths = [];
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
            simon = jsondecode(trials{j}.simon);
            lengths(end + 1) = numel(simon);
        end
    end
    writer.writeRow(participantID, taskName, lengths);
end
end