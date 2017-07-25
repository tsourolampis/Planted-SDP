n = [250, 100]; 
val =  linspace(0,1,41); 
run =  zeros(41,1); 
acc = zeros(41,1); 
for i = 1 : length(val)     
    p = 0.5+ val(i)/2; 
    q = 0.5- val(i)/2; 
    [accuracy, runtime] =  Hajek(n,p,q);
    run(i) = runtime; 
    acc(i) = accuracy;
    fprintf('Bias %f, accuracy %f, run time %f\n',val(i),  acc(i), run(i)); 
end 


run2 =  zeros(20,1); 
acc2 = zeros(20,1); 
delta = 0.05;
nodes =  round( linspace(10,250,20) );
for i = 1 : length(nodes) 
    n1 = nodes(i);
    n = [250, n1];
    fprintf('Cluster size %f\n',n1); 
    p = 0.5+ delta/2; 
    q = 0.5- delta/2;  
    [accuracy, runtime] =  Hajek(n,p,q);
    run2(i) = runtime; 
    acc2(i) = accuracy;
end 



