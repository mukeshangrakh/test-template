import matlab.unittest.parameters.Parameter
import matlab.unittest.TestSuite
import matlab.unittest.TestRunner
import matlab.unittest.Verbosity
import matlab.unittest.plugins.XMLPlugin
import matlab.io.xml.dom.*
%runner = TestRunner.withTextOutput('OutputDetail', Verbosity.Detailed);
rootDir = pwd();
outputDirectory = fullfile(rootDir,"report");
%runner.addPlugin(XMLPlugin.producingJUnitFormat(fullfile(outputDirectory,'test_report.xml')));
testFileInfo = dir(fullfile(rootDir,"code"));
addpath(testFileInfo.folder);
[arg1,arg2,arg3] = Getparameters();
doc = Document();
a = string.empty(0,length(arg1));
for i=1:length(arg1)
    a(i) = sprintf("test_report_%s%s",arg1(i),".xml");
    xmlFileName = fullfile(rootDir,"report",a(i));
    writer = matlab.io.xml.dom.DOMWriter;
    writeToFile(writer,doc,xmlFileName);
end
for i=1:length(arg1)
    runner = TestRunner.withTextOutput('OutputDetail', Verbosity.Detailed);
    runner.addPlugin(XMLPlugin.producingJUnitFormat(fullfile(outputDirectory,string(a(i)))));
    param = Parameter.fromData("fname",{arg1(i)},"ainput",{arg2(i)},"exp_output",{arg3(i)});
    suite2 = TestSuite.fromClass(?SolverTest,"ExternalParameters",param);
    results = runner.run(suite2);
    disp(results)
end
