function [] = getIndividualAudioSegments(SegmentsFile,bigWavFile,OutFileBase,buffer,speakers)

% Anne Warlaumont
% anne.warlaumont@gmail.com 
%
% Before running this program, run the "segments.pl" program on the recording .its file
% You will use the output of that program as input for this program
%
% Instructions:
% 1.) If you wish, create a new a folder to hod the small wav files (this program will produce a lot of them)
% 2.) In the command window, type: getIndividualAudioSegments(SegmentsFile,bigWavFile,OutFileBase,buffer,speaker) where:
%     SegmentsFile = The name of the Segments .csv file
%         e.g., '~/Desktop/Gina/Participants/WW05/e20131210_144819_009143_Segments.csv'
%     bigWavFile = The full .wav file of the recording
%         e.g., '~/Desktop/Gina/Participants/WW05/e20131210_144819_009143.wav'
%     OutFileBase = Where audio segments will be written + the beginning part of each segment filename
%         e.g., '~/Desktop/Gina/Participants/WW05/Segments/e20131210_144819_009143' 
%     buffer = Should be in seconds and will add some time to the beginning and ending of each audio segment before extracting it 
%         e.g., '0' or '.3'
%     speakers = An array holding the speaker types whose segments you would like to output. E.g. {'CHNSP','FAN','MAN'} for child speech-related, female adult, and male adult, "near" (loud) segments only. 
%     e.g., '~/Desktop/Gina/Participants/WW05/e20131210_144819_009143_Segments.csv','~/Desktop/Gina/Participants/WW05/e20131210_144819_009143.wav','~/Desktop/Gina/Participants/WW05/Segments/e20131210_144819_009143','0',{'CHNSP','FAN','MAN'});
% 3.) Press Return to run the program

%play the individual speaker segments:
SEF_fid = fopen(SegmentsFile);
StartEndTimes = textscan(SEF_fid,'%s %f %f','Delimiter',',','HeaderLines',1);
fs = 16000;
for segment = 1:size(StartEndTimes{1,1},1)
    speaker = StartEndTimes{1,1}(segment);
    if sum(strcmp(speaker,speakers)>0)
        smallWav = audioread(bigWavFile,[max(round((StartEndTimes{1,2}(segment)-buffer)*fs),1),round((StartEndTimes{1,3}(segment)+buffer)*fs)]);
        audiowrite([OutFileBase,'_Segment_',num2str(segment),'_',char(StartEndTimes{1,1}(segment)),'.wav'],smallWav,fs);
    end
end
fclose(SEF_fid);
