classdef SolverTest < matlab.unittest.TestCase
    properties (TestParameter)
        fname = struct("func_name","a");
        ainput = struct("input_value","b");
        exp_output = struct("exp_val","c");
    end
    methods(Test)
        function realSolution(testCase,fname,ainput,exp_output)
            b = eval(ainput);
            fh = str2func(fname);
            actSolution = fh(b{:});
            expSolution = eval(exp_output);
            testCase.verifyEqual(actSolution,expSolution)
        end
    end
end