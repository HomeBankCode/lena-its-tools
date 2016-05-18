function [duration,meanf0,dB] = getPraatAcoustics(wavFileDir,wavFileNoExt)

% Anne S. Warlaumont
%
% Example usage:
% getPraatAcoustics('/Users/awarlau/Dropbox/LENAInteraction/MemphisLENARecordings/Segments/','e20110203_113442_007541_Segment_1_AN')
% This script is called by "getCHacousticsTS.m"


% Delete the Praat output file:
if exist('tempPraatMeasurements.txt','file')==2
	delete('tempPraatMeasurements.txt');
end

% Write the Praat script:
PraatScript_fid = fopen('tempPraatScript.praat','w');
fprintf(PraatScript_fid,['Read from file... ',wavFileDir,wavFileNoExt,'.wav\n']);
fprintf(PraatScript_fid,['fileappend tempPraatMeasurements.txt ',wavFileNoExt,' \n']);
fprintf(PraatScript_fid,['select Sound ',wavFileNoExt,'\n']);
fprintf(PraatScript_fid,'mydur$ = Get total duration\n');
fprintf(PraatScript_fid,'fileappend tempPraatMeasurements.txt Duration: ''mydur$''\n');
fprintf(PraatScript_fid,'To Pitch... 0 75 1000\n');
fprintf(PraatScript_fid,['select Pitch ',wavFileNoExt,'\n']);
fprintf(PraatScript_fid,'myf0$ = Get mean... 0 0 Hertz\n');
fprintf(PraatScript_fid,'fileappend tempPraatMeasurements.txt , f0 mean: ''myf0$''\n');
fprintf(PraatScript_fid,['select Sound ',wavFileNoExt,'\n']);
fprintf(PraatScript_fid,'myintensity$ = Get intensity (dB)\n');
fprintf(PraatScript_fid,'fileappend tempPraatMeasurements.txt , Intensity: ''myintensity$''\n');
fclose(PraatScript_fid);

% Run the Praat script:
system(['/Applications/Praat.app/Contents/MacOS/Praat tempPraatScript.praat']);

% Get out the duration, mean f0, and intensity estimate that were output by the Praat script:
PraatAcoustics_fid = fopen(['tempPraatMeasurements.txt'],'a');
fprintf(PraatAcoustics_fid,'\n');
fclose(PraatAcoustics_fid);
PraatAcoustics_fid = fopen(['tempPraatMeasurements.txt']);
PraatOutput = textscan(PraatAcoustics_fid,'%*s %*s %n %*s %*s %*s %s %*s %n %*s');
if strcmp(PraatOutput{1,2},'--undefined--');
    PraatOutput{1,2} = NaN;
    fclose(PraatAcoustics_fid);
else 
    fclose(PraatAcoustics_fid);
    PraatAcoustics_fid = fopen('tempPraatMeasurements.txt');
    PraatOutput = textscan(PraatAcoustics_fid,'%*s %*s %n %*s %*s %*s %n %*s %*s %n %*s');
    fclose(PraatAcoustics_fid);
end
duration = PraatOutput{1,1};
meanf0 = PraatOutput{1,2};
dB = PraatOutput{1,3};

% Delete the Praat script:
if exist('tempPraatScript.praat','file')==2
	delete('tempPraatScript.praat');
end
