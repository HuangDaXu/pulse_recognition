function FaceNum=Faceget(VideoName)

    %����������ȡ        

    fpath= fullfile(VideoName);
    % Create a cascade detector object.
    faceDetector = vision.CascadeObjectDetector();
    % Read a video frame and run the detector.
    videoFileReader = vision.VideoFileReader(fpath);

    video=VideoReader(fpath);
    videoNum = video.NumberOfFrames;

    videoFrame = step(videoFileReader);
    tempbbox = step(faceDetector, videoFrame);

    boxInserter  = vision.ShapeInserter('BorderColor','Custom','CustomBorderColor',[255 255 0]);

    % ������Ƶ��һ֡��ȡ������ö����ĸ����͸��ԵĴ�С
    SizeBox=size(tempbbox);
    FaceNum=SizeBox(1);
    disp(['����⵽',num2str(FaceNum),'������']);

    % tempstr=cell(FaceNum,1);
    % for i=1:1:FaceNum
    %     tempstr{i}=['��ȡ��',int2str(i),'������'];
    % end
    % set(handles.face_choose,'string',tempstr);%��ʾ��ȡ�����ĸ���

    fr=1;  
    for i=1:FaceNum      %��¼��һ֡��ȡ�����������ĸ�����
        StartX(i,fr)=tempbbox(i,1);
        StartY(i,fr)=tempbbox(i,2);
        X(i,fr)=tempbbox(i,3);
        Y(i,fr)=tempbbox(i,4);
    end;
    Standardbbox=tempbbox;  %�Ե�һ֡��bboxΪ��������֡bbox�ı�׼

    % Create a video player object for displaying video frames.
    videoInfo    = info(videoFileReader);
    videoPlayer  = vision.VideoPlayer('Position',[300 300 videoInfo.VideoSize+30]);

    % ��ÿһ֡��Ƶ��ȡ������������һ�����������ĸ����͸��Դ�С
    while ~isDone(videoFileReader)
        fr=fr+1;

        % Extract the next video frame
        videoFrame = step(videoFileReader);
        % RGB -> HSV
        [hueChannel,~,~] = rgb2hsv(videoFrame);

        % Track using the Hue channel data
        %bbox = step(tracker, hueChannel);
        tempbbox = step(faceDetector, videoFrame);

        %���ݵ�һ֡��ȷ�������ĸ����͸��Դ�С������ȡ���
        tempSizeBox=size(tempbbox);
        tempFaceNum=tempSizeBox(1);
        bbox=Standardbbox;
        for i=1:FaceNum      %��¼��һ֡��ȡ�����������ĸ�����
            FaceFind=0;
            for j=1:tempFaceNum
                if (abs(tempbbox(j,1)-StartX(i,fr-1))<=50) & (abs(tempbbox(j,2)-StartY(i,fr-1))<=50)
                   bbox(i,:)=tempbbox(j,:);
                   FaceFind=1;
                   break;
                end
            end
            if ~FaceFind
                bbox(i,:)=[StartX(i,fr-1),StartY(i,fr-1),X(i,fr-1),Y(i,fr-1)];
            end
        end
        for i=1:FaceNum      %��¼��һ֡��ȡ�����������ĸ�����
            StartX(i,fr)=bbox(i,1);
            StartY(i,fr)=bbox(i,2);
            X(i,fr)=bbox(i,3);
            Y(i,fr)=bbox(i,4);
        end   
        % Insert a bounding box around the object being tracked
        videoOut = step(boxInserter, videoFrame, bbox);

        % Display the annotated video frame using the video player object
        step(videoPlayer, videoOut);

    end

    %������ȡ���������������ݴ���facedata
    for i=1:FaceNum
       MinX=X(i,1);
       MinY=Y(i,1);
       for fr=2:videoNum
           MinX=min(MinX,X(i,fr));
           MinY=min(MinY,Y(i,fr));
       end

       videoCut = VideoWriter([VideoName(1:end-4),'faceget',num2str(i)]);%��ʼ��һ��avi�ļ�
       writerObj.FrameRate = 30;
       open(videoCut);
       for fr=1:videoNum %ͼ�����и���
          temp=read(video,fr);
          tempx=StartX(i,fr)+0.5*(X(i,fr)-MinX);
          tempy=StartY(i,fr)+0.5*(Y(i,fr)-MinY);
          tempcut=imcrop(temp,[tempx,tempy,MinX,MinY]);
          writeVideo(videoCut,tempcut);
       end 
       close(videoCut);

end