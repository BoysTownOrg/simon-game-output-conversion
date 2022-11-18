classdef ConvertTestCase < matlab.unittest.TestCase
    methods (Test)
        function tbd(self)
            trial.correct = 1;
            trial.responses = '[{"milliseconds":44204,"id":1},{"milliseconds":44897.89999997616,"id":2},{"milliseconds":45672.80000001192,"id":1}]';
            trial.simon = '[{"milliseconds":39390.09999996424,"id":1},{"milliseconds":40789.80000001192,"id":2},{"milliseconds":42190.39999997616,"id":1}]';
            converted = convert(trial);
            self.assertEqual(numel(converted), 6);
            self.assertEqual(converted(1).responsetime, 39390.09999996424);
            self.assertEqual(converted(2).responsetime, 40789.80000001192);
            self.assertEqual(converted(3).responsetime, 42190.39999997616);
            self.assertEqual(converted(4).responsetime, 44204);
            self.assertEqual(converted(5).responsetime, 44897.89999997616);
            self.assertEqual(converted(6).responsetime, 45672.80000001192);
        end
    end
end