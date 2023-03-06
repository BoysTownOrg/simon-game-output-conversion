function line = extractCompleteTaskResults(line)
line = "[" + line.extractAfter('}[');
end