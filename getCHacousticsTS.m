function getCHacousticsTS(StartEndFile,wavFileDir,wavfilebase,outFile)

% Anne S. Warlaumont

SEF_fid = fopen(StartEndFile);
StartEndTimes = textscan(SEF_fid,'%s %f %f %*[^\n]');
fclose(SEF_fid);
if exist(outFile)==2
	delete(outFile);
end

outfid = fopen(outFile,'a');
fprintf(outfid,'wavfile,speaker,start,end,duration,meanf0,dB\n');

countCH = 0;
for n = 1:size(StartEndTimes{1,1},1)
    wavFileName = [wavFileDir,wavfilebase,'_Segment_',num2str(n),'_CHN.wav'];
    wavFileNoExt = [wavfilebase,'_Segment_',num2str(n),'_CHN'];
	wavFileNoPath = [wavfilebase,'_Segment_',num2str(n),'_CHN.wav'];
    if exist(wavFileName,'file')==2
        [duration,meanf0,dB] = getPraatAcoustics(wavFileDir,wavFileNoExt);
        if ~isnan(meanf0);
            countCH = countCH + 1;
			fprintf(outfid,'%s\n',strcat(wavFileNoPath,',',StartEndTimes{1,1}{n},',',num2str(StartEndTimes{1,2}(n)),',',num2str(StartEndTimes{1,3}(n)),',',num2str(duration),',',num2str(meanf0),',',num2str(dB)));
        end
    end
end

fclose(outfid);
