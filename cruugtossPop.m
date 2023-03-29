function [y1, y2] = cruugtossPop(x1, x2)
if length(x1)~=length(x2)
    y1=x1;
    y2=x2;
    
    
else
   
    nu=randi([3,length(x1)],1);
    cf=x1(nu).x;
    tf=x2(nu).x;
     
    if cf(end-1)==tf(end-1)
    y1=x1;
    y2=x2;
    else
        aw=cf(end-1);
        tw=tf(end-1);
        cf(end-1)=tf(end-1);
        tf(end-1)=aw;
       x1(nu).x=cf; 
       x2(nu).x=tf;
        
    for i=[1:nu-1,nu+1:length(x1)]
       
       t=x1(i).x ;
       tg=find(t==aw);
       if tg>0
           t(tg)=aw;
           x1(i).x=t ;
           
           
       end
       
        
        
    end
    
    
   for i=[1:nu-1,nu+1:length(x1)]
       
       t=x2(i).x ;
       gg=find(t==tw);
       if gg>0
           t(gg)=tw;
           x2(i).x =t;
           
       end
       
        
        
    end 
    
    y1=x1;
    y2=x2;
    
    end
    
    
    
    
    
    
    
    
    
end

