function converted = convert(trial)
responses = jsondecode(trial.responses);
simon = jsondecode(trial.simon);
converted(numel(responses)+numel(simon)).tbd = true;
for i = 1:numel(simon)
    converted(i).responsetime = simon.milliseconds;
end
end