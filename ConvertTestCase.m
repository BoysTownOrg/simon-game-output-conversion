classdef ConvertTestCase < matlab.unittest.TestCase
    methods (Test)
        function tbd(self)
            trial.correct = true;
            trial.simon = '[{"milliseconds":39390.09999996424,"id":1},{"milliseconds":40789.80000001192,"id":2},{"milliseconds":42190.39999997616,"id":1}]';
            trial.responses = '[{"milliseconds":44204,"id":1},{"milliseconds":44897.89999997616,"id":2},{"milliseconds":45672.80000001192,"id":1}]';
            converted = convert(trial);
            self.assertEqual(numel(converted), 6);
            self.assertEqual(converted(1).responsetime, 39390.09999996424);
            self.assertEqual(converted(2).responsetime, 40789.80000001192);
            self.assertEqual(converted(3).responsetime, 42190.39999997616);
            self.assertEqual(converted(4).responsetime, 44204);
            self.assertEqual(converted(5).responsetime, 44897.89999997616);
            self.assertEqual(converted(6).responsetime, 45672.80000001192);
            self.assertEqual(converted(1).id, 1);
            self.assertEqual(converted(2).id, 2);
            self.assertEqual(converted(3).id, 1);
            self.assertEqual(converted(4).id, 1);
            self.assertEqual(converted(5).id, 2);
            self.assertEqual(converted(6).id, 1);
            self.assertTrue(converted(1).issimon);
            self.assertTrue(converted(2).issimon);
            self.assertTrue(converted(3).issimon);
            self.assertFalse(converted(4).issimon);
            self.assertFalse(converted(5).issimon);
            self.assertFalse(converted(6).issimon);
            self.assertEmpty(converted(1).correct);
            self.assertEmpty(converted(2).correct);
            self.assertEmpty(converted(3).correct);
            self.assertTrue(converted(4).correct);
            self.assertTrue(converted(5).correct);
            self.assertTrue(converted(6).correct);
            self.assertEqual(converted(1).lengthpresented, 3);
            self.assertEqual(converted(2).lengthpresented, 3);
            self.assertEqual(converted(3).lengthpresented, 3);
            self.assertEqual(converted(4).lengthpresented, 3);
            self.assertEqual(converted(5).lengthpresented, 3);
            self.assertEqual(converted(6).lengthpresented, 3);
        end
    end
end