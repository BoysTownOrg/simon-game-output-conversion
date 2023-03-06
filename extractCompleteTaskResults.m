function line = extractCompleteTaskResults(line)
if line.contains('}[')
    line = "[" + line.extractAfter('}[');
elseif ~line.startsWith('[')
    line = "[]";
end
end