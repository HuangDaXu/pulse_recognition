load '.\data\res_test_data.mat'

res_test_map=mapminmax(res_test,0,1);


row=length(res_test_map(1,:));
col=length(res_test_map(1,:));

similarity_data=zeros(row,col);



for i =1:length(res_test_map(1,:))
    
    for j = 1:length(res_test_map(1,:))
        
        similarity_data(i,j)=compare_data(res_test_map(:,i)',res_test_map(:,j)','cosine');
    end      
    
end

sample_num = 25;
person_num = 10;
%����inside_class��outside_class

inside_class=[];
for i=1:person_num

    
    temp_inside = similarity_data((1+(i-1)*person_num):(i*person_num),(1+(i-1)*person_num):(i*person_num));
    inside=reshape(temp_inside',1,[]);
    inside_class=[inside_class,inside];
    
end

outside_class=[];
for i= 1:person_num-1
   
    temp_outside = similarity_data((1+(i-1)*person_num):(i*person_num),(1+i*person_num):row);
    outside=reshape(temp_outside',1,[]);
    outside_class=[outside_class,outside];
    
end

%����frr��far��err����ͼ
frr_far_err(inside_class,outside_class)



