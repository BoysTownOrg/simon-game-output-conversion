function converted = convert(trial)
responses = jsondecode(trial.responses);
simon = jsondecode(trial.simon);
converted(numel(responses)+numel(simon)).id = 0;
for i = 1:numel(simon)
    converted(i).responsetime = simon(i).milliseconds;
    converted(i).id = simon(i).id;
    converted(i).issimon = true;
    converted(i).correct = [];
end
for i = 1:numel(responses)
    converted(i+numel(simon)).responsetime = responses(i).milliseconds;
    converted(i+numel(simon)).id = responses(i).id;
    converted(i+numel(simon)).issimon = false;
    converted(i+numel(simon)).correct = trial.correct;
end
for i = 1:numel(converted)
    converted(i).lengthpresented = numel(simon);
end
if all(isfield(trial, ["block", "isRandom"]))
    for i = 1:numel(converted)
        converted(i).lengthpresented = numel(simon);
        converted(i).block = trial.block;
        converted(i).israndom = trial.isRandom;
    end
end
end