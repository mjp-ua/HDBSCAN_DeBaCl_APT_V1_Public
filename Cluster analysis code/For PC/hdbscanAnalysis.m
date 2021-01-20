%HDBSCAN python is called in this function
function hdbscanCluster=hdbscanAnalysis(DatasetName,hdbscanPersistencyThreshold,hdbscanProbabilityThreshold,MinClusterSizeHDBSCAN,MinSamplesHDBSCAN,AxisLimits)
    if exist('HDBSCANoutputs','dir')==7 %It is used to make hdbscanCluster in hdbscanPostProcess function
        rmdir HDBSCANoutputs s
    end
    mkdir HDBSCANoutputs
    copyfile(DatasetName, 'TempHDBSCANfile.txt')

    fid1 = fopen('TempHDBSCANparameters.txt','wt');
    fprintf(fid1, '%d\n', MinClusterSizeHDBSCAN);
    fprintf(fid1, '%d', MinSamplesHDBSCAN);
    fclose(fid1);
    
    pyExec = 'C:\Users\student\anaconda3\'; %Change this C path to wherever your anaconda3 folder is located
    pyRoot = fileparts(pyExec);
    p = getenv('PATH');
    p = strsplit(p, ';');
    addToPath = {
       pyRoot
       fullfile(pyRoot, 'Library', 'mingw-w64', 'bin')
       fullfile(pyRoot, 'Library', 'usr', 'bin')
       fullfile(pyRoot, 'Library', 'bin')
       fullfile(pyRoot, 'Scripts')
       fullfile(pyRoot, 'bin')
    };
    p = [addToPath(:); p(:)];
    p = unique(p, 'stable');
    p = strjoin(p, ';');
    setenv('PATH', p);
    !conda activate base
    !python hdbscanImanSecond.py
    
    delete 'TempHDBSCANparameters.txt'
    delete 'TempHDBSCANfile.txt'
    hdbscanCluster=hdbscanPostProcess(DatasetName);

end