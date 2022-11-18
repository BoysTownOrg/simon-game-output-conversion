function convertJatosOutput
[file, path] = uigetfile('*.txt');
lines = readlines([path filesep file]);
circles = jsondecode(lines(2));
circlesTable = table();
for i = 3:numel(circles)-1
    subtable = struct2table(convert(circles{i}));
    participant_id = repmat(circles{1}.response.participant_id, height(subtable), 1);
    trial = repmat(i - 2, height(subtable), 1);
    circlesTable = [circlesTable; addvars(subtable, participant_id, trial)];
end
writetable(circlesTable, [file(1:end-4), '_id_', circles{1}.response.participant_id, '.csv']);
end