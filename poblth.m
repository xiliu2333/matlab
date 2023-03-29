function Z=poblth(x,A1,B,S0,S1,S2,S3,v1,v2)
Cak=5;
Cav=40;
Cbk=5;
Cbv=1;
eta=0.3;
A1=A1*1000;
S0=S0*1000;
S1=S1*1000;
S2=S2*1000;
S3=S3*1000;
for j=1:length(x)
    t=x(j).x;
    n=0;
    s=0;
    if t(2)==0.1||t(2)==0.2||t(2)==0.3
        n=n+1;
    else
        s=s+1;
    end
    
        u1=t(1:end-1);
        u2=t(2:end);
        
        for i=1:length(u1)
            if u1(i)==0&&u2(i)==0.1
                d(i)=sqrt((S0(1)-S1(1))^2+(S0(2)-S1(2))^2);
            elseif u1(i)==0&&u2(i)==0.2
                d(i)=sqrt((S0(1)-S2(1))^2+(S0(2)-S2(2))^2);
            elseif u1(i)==0&&u2(i)==0.3
                d(i)=sqrt((S0(1)-S3(1))^2+(S0(2)-S3(2))^2);    
                
            elseif u1(i)==0&&u2(i)>=1
                d(i)=sqrt((S0(1)-A1(u2(i),1))^2+(S0(2)-A1(u2(i),2))^2);
             elseif u1(i)>1&&u2(i)>=1  
                  d(i)=sqrt((A1(u1(i),1)-A1(u2(i),1))^2+(A1(u1(i),2)-A1(u2(i),2))^2);
            elseif u1(i)==0.1&&u2(i)>=1
                d(i)=sqrt((S1(1)-A1(u2(i),1))^2+(S1(2)-A1(u2(i),2))^2);
            elseif u1(i)==0.2&&u2(i)>=1   
                d(i)=sqrt((S2(1)-A1(u2(i),1))^2+(S2(2)-A1(u2(i),2))^2);
             elseif u1(i)==0.3&&u2(i)>=1   
                d(i)=sqrt((S3(1)-A1(u2(i),1))^2+(S3(2)-A1(u2(i),2))^2);  
             elseif u1(i)>=1&&u2(i)==0
                d(i)=sqrt((S0(1)-A1(u1(i),1))^2+(S0(2)-A1(u1(i),2))^2);
              elseif u1(i)>=1&&u2(i)==0.1  
                d(i)=sqrt((S1(1)-A1(u1(i),1))^2+(S1(2)-A1(u1(i),2))^2);
               elseif u1(i)>=1&&u2(i)==0.2  
                d(i)=sqrt((S2(1)-A1(u1(i),1))^2+(S2(2)-A1(u1(i),2))^2); 
            else
               d(i)=sqrt((S3(1)-A1(u1(i),1))^2+(S3(2)-A1(u1(i),2))^2); 
               
                
                
            end
            
            
        end
        if t(2)==0.1||t(2)==0.2||t(2)==0.3
            dm(j)=Cbv*sum(d)*(1+eta);
        else
            dm(j)=Cbk*sum(d)*(1+eta);
            
        end
       
        
        
        
end
Z1=sum(dm)+n*Cak+s*Cav;
for j=1:length(x)
    t=x(j).x;
    if t(2)==0.1||t(2)==0.2||t(2)==0.3
        time(1)=0;
        time(2)=0;
        time(3)=B(t(3),1);
        
        f(1)=1;
         f(2)=1;
          f(3)=1;
          
        if numel(t)>4
         for i=4:length(t)-1
             
             time(i)=time(i-1)+sqrt((A1(t(i-1),1)-A1(t(i),1))^2+(A1(t(i-1),2)-A1(t(i),2))^2)/v1/3600;
             if time(i)>B(t(i),1)&&time(i)<B(t(i),2)
                 f(i)=1;
             else
                 f(i)=0;
                 
             
                 
             end
             
         end
             
        end
         lk(j)=sum(f);
        gh(j)=numel(f);
       clear f time
        
    else
        
         time(1)=0;
        time(2)=B(t(2),1);
         f(1)=1;
         f(2)=1;
        
         if numel(t)>3
         for i=3:length(t)-1
             
             time(i)=time(i-1)+sqrt((A1(t(i-1),1)-A1(t(i),1))^2+(A1(t(i-1),2)-A1(t(i),2))^2)/v2/3600;
             if time(i)>B(t(i),1)&&time(i)<B(t(i),2)
                 f(i)=1;
             else
                 f(i)=0;
                 
             
                 
             end
             
         end
           lk(j)=sum(f);
        gh(j)=numel(f);
          clear f time
         
         
        
        
    end
    
    
    
    
    
end






end
Z2=1-sum(lk)/sum(gh);
Z=Z1+10^5*Z2;