classdef SimonLengthsCsvWriter < handle
    properties (Access = private)
        fid
    end

    methods
        function self = SimonLengthsCsvWriter(filepath)
            self.fid = fopen(filepath, 'w');
        end

        function writeRow(self, participantID, taskName, lengths)
            fprintf(self.fid, '%s,%s', participantID, taskName);
            for i = 1:numel(lengths)
                fprintf(self.fid, ',%d', lengths(i));
            end
            fprintf(self.fid, '\n');
        end

        function delete(self)
            fclose(self.fid);
        end
    end
end