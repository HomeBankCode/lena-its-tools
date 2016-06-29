function getCHacousticsTS(SegmentsFile,wavFileDir,wavfilebase,outFile)

% Anne S. Warlaumont

% Before running this program, run the "gteIndividualAudioSegments.m" program.
% This program will run on the audio segments you created with that program.
%
% Instructions:
% 1.) Be sure you have downloaded the "getPraatAcoustics.m" script, as this
% script calls upon it.
% 2.) In the command window, type: getCHacousticsTS(SegmentsFile,wavFileDir,wavfilebase,outFile) where:
%       SegmentsFile = The name of the Segments .csv file
%         e.g., '~/Desktop/Gina/Participants/WW05/e20131210_144819_009143_Segments.csv'
%       wavFileDir = The directory where the audio segments live
%         e.g., '~/Desktop/Gina/Participants/WW05/Segments/e20131210_144819_009143'
%       wavfilebase = The name base for the .wav file segments
%         e.g., 'e20131210_144819_009143' 
%       outFile = The path and name of the output file where you want the time series to be written
%     For example: '~/Desktop/Gina/Participants/WW05/e20131210_144819_009143CHNStartEndUttCryTimes.txt','~/Desktop/Gina/Participants/WW05/Segments/','e20131210_144819_009143','~/Desktop/Gina/Participants/WW05/e20131210_144819_009143CHAcoustics_Output.txt');
% 3.) Press Return to run the program

speaker = 'CHNSP';

SEF_fid = fopen(SegmentsFile);
StartEndTimes = textscan(SEF_fid,'%s %f %f','Delimiter',',','HeaderLines',1);
fclose(SEF_fid);
if exist(outFile)==2
	delete(outFile);
end

outfid = fopen(outFile,'a');
fprintf(outfid,'wavfile,speaker,start,end,duration,meanf0,dB\n');

countCH = 0;
for n = 1:size(StartEndTimes{1,1},1)
	if sum(strcmp(speaker,speakers)>0)
	    wavFileName = [wavFileDir,wavfilebase,'_Segment_',num2str(n),'_',speaker,'.wav'];
	    wavFileNoExt = [wavfilebase,'_Segment_',num2str(n),'_',speaker];
		wavFileNoPath = [wavfilebase,'_Segment_',num2str(n),'_',speaker,'.wav'];
	    if exist(wavFileName,'file')==2
	        [duration,meanf0,dB] = getPraatAcoustics(wavFileDir,wavFileNoExt);
	        if ~isnan(meanf0);
	            countCH = countCH + 1;
				fprintf(outfid,'%s\n',strcat(wavFileNoPath,',',StartEndTimes{1,1}{n},',',num2str(StartEndTimes{1,2}(n)),',',num2str(StartEndTimes{1,3}(n)),',',num2str(duration),',',num2str(meanf0),',',num2str(dB)));
	        end
	    end
	end
end

fclose(outfid);
