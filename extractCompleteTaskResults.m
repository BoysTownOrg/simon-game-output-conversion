function line = extractCompleteTaskResults(line)
if line.contains('}[')
    line = "[" + line.extractAfter('}[');
end
end