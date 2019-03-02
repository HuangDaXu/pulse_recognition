function out=frr_far_err(inside_class,outside_class)

NGRA = length(inside_class);%���ڲ���
NIRA = length(outside_class);%������

FRR = [];
FAR = [];

th =  0.6:0.01:1;
for i = 1:length(th)
    
    frr = sum(inside_class>th(i))/NGRA;
    FRR=[FRR frr];
    
    far = sum(outside_class<th(i))/NIRA;
    FAR = [FAR far];
end
    figure; 
    plot(FAR, FRR); 
    grid on; 
    hold on; 
    xlabel('FAR(%)'); 
    ylabel('FRR(%)'); 
    title('ROC����')
    x=0:0.25:0.8; 
    y = x; 
    plot(x, y); 
    hold off
    
 



