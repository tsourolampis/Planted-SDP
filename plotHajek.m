function plotHajek(n2, n1_initial, step,p,q) 


n = zeros(2,1);
n(2) = n2; 
i = 1;
x = [];
for a = n1_initial: step: n(2)
    fprintf('N(1) = %d, N(2) = %d \n',a,n(2));
    n(1) = a;
    [acc, tim]  =  Hajek(n,p,q); 
    runtime(i) =tim;
    x(i) = acc; 
    i=i+1;
end



figure
plot(n1_initial: step: n(2), x,'r-')
title('Accuracy')
print('-dpng', strcat('Planted_Partition_Accuracy_', num2str(p),'_',num2str(q),'.png' ));    

figure
plot(n1_initial: step: n(2), runtime,'r-')
title('Run time')
print('-dpng', strcat('Planted_Partition_Runtime_', num2str(p),'_',num2str(q),'.png' ));    

