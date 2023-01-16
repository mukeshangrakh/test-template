function codecheckToolbox(rootDir)
    arguments
        rootDir (1,1) string  = pwd();
    end

    testFileInfo = dir(fullfile(rootDir,"test","*.m"));
    filesToCheck = fullfile(string({testFileInfo.folder}'),string({testFileInfo.name}'));

    testFileInfo = dir(fullfile(rootDir,"test","*.mlx"));
    filesToCheck = [filesToCheck;fullfile(string({testFileInfo.folder}'),string({testFileInfo.name}'))];
    
    testFileInfo = dir(fullfile(rootDir,"code","*.m"));
    filesToCheck = [filesToCheck;fullfile(string({testFileInfo.folder}'),string({testFileInfo.name}'))];

    testFileInfo = dir(fullfile(rootDir,"code","*.mlx"));
    filesToCheck = [filesToCheck;fullfile(string({testFileInfo.folder}'),string({testFileInfo.name}'))];
    
    if isempty(filesToCheck)
        error("%s:codeissues",string("Test Template"),"No files to check.")
    else
        issues = checkcode(filesToCheck);
        issues = [issues{:}];
        issueCount = size(issues,1);
        fprintf("checked %d files with %d issue(s).\n",numel(filesToCheck),issueCount)
        % Generate the JSON files for the shields in the readme.md
        switch issueCount
            case 0
                color = "green";
            case 1
                color = "yellow";
            otherwise
                color = "red";
        end
        writeBadgeJSONFile("code issues",string(issueCount), color)
        if issueCount ~= 0
            checkcode(filesToCheck)
            error("%s:codeissues",string("Test Template"),"%s Toolbox requires all code check issues be resolved.",string("Test Template"))
        end
    end
end
