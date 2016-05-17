function [] = getIndividualAudioSegments(StartEndFile,bigWavFile,OutFileBase,buffer)

% Anne Warlaumont
% anne.warlaumont@gmail.com 
%
% Before running this program, run the "readits_start_end_content.pl" program on the recording .its file
% You will use the combined AN and CHN file as input for this program
%
% Instructions:
% 1.) Create a folder named "Segments" within the directory that holds the
% combined AN and CHN file (that was created when
% "readits_start_end_content.pl" was run)
% 2.) In the command window, type: getIndividualAudioSegments(StartEndFile,bigWavFile,OutFileBase,buffer) where:
%     StartEndFile = The name of the combined AN and CHN .txt file
%         e.g., '~/Desktop/Gina/Participants/WW05/e20131210_144819_009143CHNStartEndUttCryTimes.txt'
%     bigWavFile = The full .wav file of the recording
%         e.g., '~/Desktop/Gina/Participants/WW05/e20131210_144819_009143.wav'
%     OutFileBase = Where audio segments will be written (the "Segments"
%     folder created in Step 1)
%         e.g., '~/Desktop/Gina/Participants/WW05/Segments/e20131210_144819_009143' 
%     buffer = Should be in seconds and will add some time to the beginning and ending of each audio segment before extracting it 
%         e.g., '1'
%     e.g., '~/Desktop/Gina/Participants/WW05/e20131210_144819_009143CHN_AN_Segments.txt','~/Desktop/Gina/Participants/WW05/e20131210_144819_009143.wav','~/Desktop/Gina/Participants/WW05/Segments/e20131210_144819_009143','1');
% 3.) Press Return to run the program

%play the individual speaker segments:
SEF_fid = fopen(StartEndFile);
StartEndTimes = textscan(SEF_fid,'%s %f %f %*[^\n]');
fs = 16000;
for segment = 1:size(StartEndTimes{1,1},1)
    
    smallWav = audioread(bigWavFile,[max(round((StartEndTimes{1,2}(segment)-buffer)*fs),1),round((StartEndTimes{1,3}(segment)+buffer)*fs)]);
    
    % Uncomment the line below if you want to save each segment in its own wav file
    audiowrite([OutFileBase,'_Segment_',num2str(segment),'_',char(StartEndTimes{1,1}(segment)),'.wav'],smallWav,fs);
    
    % Uncomment the lines below if you want to play the individual segments
    % sound(smallWav,fs);
    % pause();
    
end
fclose(SEF_fid);
