function convertJatosOutput
[file, path] = uigetfile('*.txt');
lines = readlines([path, filesep, file]);
lines(lines.strlength == 0) = [];
json = arrayfun(@(s)jsondecode(s), lines, 'UniformOutput', false);
tasks = {'colors', 'squares'};
for task = 1:2
    trials = jsondecode(lines(task+1));
    outputTable = table();
    for i = 3:numel(trials)-1
        trialTable = struct2table(convert(trials{i}));
        participant_id = repmat(string(trials{1}.response.participant_id), height(trialTable), 1);
        trial = repmat(i - 2, height(trialTable), 1);
        outputTable = [outputTable; addvars(trialTable, participant_id, trial)];
    end
    writetable(outputTable, ['simon-', tasks{task}, '-task', '_id_', trials{1}.response.participant_id, '.csv']);
end
end