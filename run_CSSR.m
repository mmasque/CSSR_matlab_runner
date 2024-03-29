function [complexity] = run_CSSR(dataset, alphabet_FName, L_Max, output_FName, multiline)
%{
    run command prompt version of CSSR through MatLab directly.
    Usage: 
        
        - in a terminal, type 'make' in the directory cpp Makefile is stored.
        - 'cp' the resuting CSSR exe file into your path (on a mac this is
        'usr/local/bin') 
        - ensure run_CSSR.m and convert_dataset_to_textfile.m are in your
        MATLAB path (right-click on the folder they are in and select add to
        path)
        - set your MATLAB current folder to the folder containing the
        alphabet file. 
        - call run_CSSR with the appropriate arguments
        

    arguments:
        dataset: epochs x timestamp double, where each epoch is a trial to
        be considered independently.
        
        alphabet_FName: a string of the file name of the alphabet to use. 
                        if using a binary alphabet, "binary01-alphabet.txt"
                        can be used. 

        L_Max: num - maximum memory length

        output_FName: the name all output files should start with. Do not
        include type extension.
        
        multiline: boolean, True if multiple trials. 

        NOTE: due to the command line design of the CSSR algorithm, it is
        difficult to set the alpha value through MATLAB. modify the Test.h
        file SIGLEVEL definition to set an alpha. IMPORTANT: set it to
        0.005 to be consistent with the fly paper. it defaults to 0.001.
    outputs:
        complexity: double - statistical complexity of the system
        
        for file outputs, see README
%}
dataset_FName = strcat(output_FName, "L", num2str(L_Max));
convert_dataset_to_textfile(dataset, dataset_FName);
%alphabet_FName = "binary01-alphabet.txt";


%L_Max = 4;
%alpha set to 0.005
with_txt = strcat(dataset_FName, ".txt");
change_name = strcat("mv ", with_txt," ", dataset_FName);
system(change_name)
call_CSSR = strcat("CSSR ", alphabet_FName, " ", dataset_FName, " ",...
    num2str(L_Max));
if multiline
    call_CSSR = strcat(call_CSSR, " -m");
end
system(call_CSSR)

info_fname = strcat(dataset_FName, "_info");
A = readmatrix(info_fname, "Delimiter", ":");
complexity = A(8, 2);
end