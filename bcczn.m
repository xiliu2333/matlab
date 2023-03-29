function hut=bcczn(A1,zr,B)
qe=zr;
s1=0;
s2=0;

for i=1:length(A1)
    if A1(i,3)==1
        s1=s1+1;
    A01(s1)=i;
    else
        s2=s2+1;
        A02(s2)=i;
    
    end
end

% A0=1:length(A1);
n=1;
ter.x=[];
eru=repmat(ter,1,length(A1));
fe=zeros(1,1);

while length(A01)>1
    t=eru(n).x;
    m=randi(length(A01));
    t(1)=A01(m);
    fe(1)=qe(m);
    A01(m)=[];
    qe(m)=[];
  
[~,tp]=sort(B(A01,1));
    A01=A01(tp);
    qe1=qe(tp);

   
    for i=1:length(A01)
        fe(i+1)=qe1(1);
%         t(i+1)=A0(1);
%         A0(1)=[];
%         qe(1)=[];
        if sum(fe)>23
            
            
            break
        end
        t(i+1)=A01(1);
        A01(1)=[];
        qe1(1)=[];
        
        
    end
    
 t=[0,t,0];
   eru(n).x=t;
   
    n=n+1;
    clear fe  t tr tp m df
    
    
    
end
t=A01;
t=[0,t,0];
 eru(n).x=t;
clear fe  t tr tp m df
% hu=repmat(ter,1,n);
n1=0;
for i=1:n
    if numel(eru(i).x)>=3
    n1=n1+1;
    hu(n1).x= eru(i).x;
   
    end
end
so=n1+1;


fe=zeros(1,1);

while length(A02)>1
    t=eru(so).x;
    m=randi(length(A02));
    t(1)=A02(m);
    fe(1)=qe(m);
    A02(m)=[];
    qe(m)=[];
  [~,tp]=sort(B(A02,1));
    A02=A02(tp);
    qe1=qe(tp);
   
    for i=1:length(A02)
        fe(i+1)=qe1(1);
        if sum(fe)>23
            
            
            break
        end
        t(i+1)=A02(1);
        A02(1)=[];
        qe1(1)=[];
        
        
    end
    
    gmu=[0.1 0.2 0.3];
    
 t=[0,gmu(randi(length(gmu))),t,gmu(randi(length(gmu)))];
   eru(so).x=t;
   
    so=so+1;
    clear fe  t tr tp m df
    
    
    
end
t=A02;
 t=[0,0.1,t,0.1];
 eru(so).x=t;
clear fe  t tr tp m df



to=n1+1;
for i=n1+1:length(A1)
    if numel(eru(i).x)>=4
        
    hu(to).x= eru(i).x;
    to=to+1;
    end
end
hut=hu;



