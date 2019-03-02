function res = compare_data(sample,pattern,mode)

    if strcmp( mode,'cosine')

        %�����������ƶ�
        A=sqrt(sum(sum(sample.^2)));
        B=sqrt(sum(sum(pattern.^2)));
        C=sum(sum(sample.*pattern));

        cos_value=C/(A*B);

        %cos_arc=acos(cos_value)%����
        %v=cos_arc*180/pi%�Ƕ�

        res=cos_value;
   
    elseif strcmp(mode,'euclidean')
        
        
        %����ŷ�Ͼ���(�����Ƚ�������Ҫ��ͬ)
        X=[sample;pattern];
        res=pdist(X,'seuclidean');
    end
end







