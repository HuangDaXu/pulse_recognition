function Areacut_averaging=Areacut(VideoName,w1,w2,h1,h2,num)
    video=VideoReader(VideoName);
    videoNum = video.NumberOfFrames;% ֡������
    
%     videoHeight=video.Height;
%     videoWidth=video.Width;
%     videoColor=3;
    frame01=read(video,1);
%     figure,imshow((squeeze(frame01(:,:,1))))
%     hold on
%     plot(w1,h1,w2,h2, 'r.', 'MarkerSize', 8);
%     plot(w1,h2,w2,h1, 'r.', 'MarkerSize', 8);
%     plot(w2,h1,w1,h2, 'r.', 'MarkerSize', 8);
%     plot(w2,h2,w1,h1, 'r.', 'MarkerSize', 8);
    
    %videoCut = VideoWriter([VideoName(1:end-4),'areacut',num2str(num)]);%��ʼ��һ��avi�ļ�
    %writerObj.FrameRate = 30;
    %open(videoCut);
    for fr=1:videoNum %ͼ�����и���
        temp=read(video,fr);
        tempcut=imcrop(temp,[w1,h1,w2-w1,h2-h1]);
%         

%         ��ɫͨ����ƽ��
        Areacut_averaging(fr)=mean(mean(tempcut(:,:,2)));   

%         %����ͨ��һ����ƽ��
%         Areacut_averaging(fr)=mean(mean(tempcut(:,:,:)));   
        
% %       %ת��Ϊ��������ƽ��
%         frame(:,:,fr)= tempcut(:,:,2)*0.299+tempcut(:,:,1)*0.587+tempcut(:,:,3)*0.114;
%         Areacut_averaging(fr)=mean(mean(frame(:,:,fr)));
        
        %writeVideo(videoCut,tempcut);
    end 
	%close(videoCut);
end
