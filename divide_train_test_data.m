%ѵ���Զ������PulseNet
%�õ�ѵ���������

clear
load '.\data\train_data_30.mat'
load '.\data\test_data.mat'
X=mapminmax(train_data(:,1:100)',0,1);%��һ��
T=mapminmax(test_data(:,1:100)',0,1);

%�����Զ������
hidden_size =80;
autoenc_1=trainAutoencoder(X,hidden_size,...
    'MaxEpochs',1000,...
    'L2WeightRegularization',0.001,...
    'SparsityRegularization',4,...
    'SparsityProportion',0.05,...
    'DecoderTransferFunction','purelin');

XReconstructed = predict(autoenc_1,X);
mseError = mse(X-XReconstructed)


features_1 =encode(autoenc_1,X);



hidden_size_2=50;
autoenc_2=trainAutoencoder(features_1,hidden_size_2,...
    'L2WeightRegularization',0.001,...
    'SparsityRegularization',4,...
    'SparsityProportion',0.05,...
    'DecoderTransferFunction','purelin');

features_2=encode(autoenc_2,features_1);

hidden_size_3=25;
autoenc_3=trainAutoencoder(features_2,hidden_size_3,...
    'L2WeightRegularization',0.001,...
    'SparsityRegularization',4,...
    'SparsityProportion',0.05,...
    'DecoderTransferFunction','purelin');

features_3=encode(autoenc_3,features_2);

%�����Զ�������ı�������ջ
autoenc=stack(autoenc_1,autoenc_2,autoenc_3);
view(autoenc);

res_train=autoenc(X);

%��ѵ���������ջ�Զ������Ҳ����PulseNet�еõ���ȡ������������
res_test=autoenc(T);
save('.\data\res_test_data_30.mat','res_test')%����ѵ���õ�����õ�������������µ�����������
save('.\data\res_train_data_30.mat','res_train')


%�������ӻ�
figure(1)
h=plotWeights(autoenc_1);
figure(2)
h_2=plotWeights(autoenc_2);
figure(3)
h_3=plotWeights(autoenc_3);






