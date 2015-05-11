function [] = getIndividualAudioSegments(StartEndFile,bigWavFile,OutFileBase,buffer)

% Anne Warlaumont
% anne.warlaumont@gmail.com 
%
% Assumes that you have already run readits_start_end_content.pl program on the recording its file
%
% Example usage:
% getIndividualAudioSegments('/Users/awarlau/Dropbox/LENAInteraction/MemphisLENARecordings/postitsfiles/e20110203_113442_007541CombinedCHNANStartEndUttCryTimes.txt','/Users/awarlau/Dropbox/LENAInteraction/MemphisLENARecordings/wavfiles/e20110203_113442_007541.wav','/Users/awarlau/Dropbox/LENAInteraction/MemphisLENARecordings/Segments/e20110203_113442_007541');
%
% buffer should be in seconds and will add some time to the beginning and
% ending of each audio segment before extracting it.

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
