function [FName,FInput,FOutput] = Getparameters()

% get the current directory and read the test_parameters text file line by
% line
rootDir = pwd();
testFileInfo = fullfile(rootDir,"tests","Test_parameters.txt");
tline = readlines(testFileInfo);
tline = tline(string(tline)~="");

%Create 3 arrays to read function name, input arguments and expected output
FName = [];FInput = [];FOutput = [];
for i=1:length(tline)
    a_split = strsplit(tline(i),':');
    if strcmp(a_split(1),"Input parameter")
        FInput = [FInput a_split(2)];
    elseif strcmp(a_split(1),"Expected Output")
        FOutput = [FOutput a_split(2)];
    else
        FName = [FName a_split(1)];
    end
end
end
