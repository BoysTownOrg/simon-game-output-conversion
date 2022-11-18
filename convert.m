function converted = convert(trial)
responses = jsondecode(trial.responses);
simon = jsondecode(trial.simon);
converted(numel(responses)+numel(simon)).tbd = true;
end