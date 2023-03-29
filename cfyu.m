clc;clear;close all
tic
nVar = 6; 
nPop = 50; %设置种群数量
maxIt =20; %设置最大迭代次数
nPc = 0.86; %设置子代的比例
nC = round(nPop * nPc / 2) * 2; %设置子代个数
nMu = 0.4; %设置变异概率
template.x = [];%优化变量的存储矩阵
template.y = [];%适应度函数值
v1=10/1.2;
v2=25*10^3/3600;

S0=[116.575813, 39.79704];
S1=[116.560000, 39.803900	
];
S2=[116.589980, 39.815313	
];
S3=[116.593580, 39.783500	
];
Parent = repmat(template, nPop, 1);%父代个体
A1=[
116.584757, 39.772592		2
116.591543, 39.799114		2
116.59585, 39.790280		2
116.591401, 39.808990		2
116.58452, 39.810590		2
116.583775, 39.813181		2
116.578084, 39.801451		1
116.595466, 39.776311		2
116.590885, 39.774446		2
116.60086, 39.778890		2
116.58783, 39.820078		2
116.596207, 39.821640		2
116.563377, 39.834260		1
116.564741, 39.785986		2
116.562433, 39.784759		2
116.581598, 39.800093		1
116.569285, 39.804245		2
116.5866, 39.806140		    2
116.583034, 39.807903		2
116.554042, 39.817183		2
116.56743, 39.803398		2
116.576403, 39.803122		1
116.576203, 39.788296		1
116.577568, 39.783278		1
116.598746, 39.801840		2
116.551365, 39.823293		2
116.568935, 39.793330		2
116.564848, 39.782858		2
116.551796, 39.782789		2
116.592309, 39.789595		2
116.560000, 39.803900       1
116.589980, 39.815313       1
116.593580, 39.783500       1
];%输入订单矩阵，按照一行四列的格式输入
zr=[2.45
1
1.68
1.54
2.37
1.7
1.05
9.64
2.75
7.61
7.81
3.36
4.96
2.13
9.59
7.93
8.53
4.69
1.22
5.62
2.91
7.76
1.85
8.33
2.86
1.26
7.13
9.17
7.64
3.8
0
0
0
];
B=[9	10
10	11
10	11
9	11
10	11
10	12
9	10
11	12
9	11
10	11
10	12
9	10
9	10
10	11
9	10
10	11
10	12
9	11
10	11
10	11
11	12
9	10
10	11
9	10
9	11
10	12
10	11
10	11
11	12
9	10
9	12
9	12
9	12
9   10
9   10
9   10
];


for i=1:length(Parent)
  Parent(i).x=bcczn(A1,zr,B);
Parent(i).y=poblth( Parent(i).x,A1,B,S0,S1,S2,S3,v1,v2);
    
end
gt=zeros(1,maxIt);
lt=zeros(maxIt,2);
h0=animatedline(0,1.3*10^4,'color',[ 0.45 0.31 0.4],'LineWidth',1);

for It = 1 : maxIt
    
   
    Offspring = repmat(template, nC/2, 2);
    
    for j = 1 : nC / 2     
        
      
        p1 = selectPop1(Parent);
        p2 = selectPop1(Parent);
        
    
        [Offspring(j, 1).x, Offspring(j, 2).x] = cruugtossPop(p1.x, p2.x);%子代个体
        
    end
    
    Offspring = Offspring(:);
    
   
    for k = 1 :nC
        Offspring(k).x = mvhdaterp(Parent(k).x,nMu,A1,zr,B);
    
        
       Offspring(k).y=poblth( Offspring(k).x,A1,B,S0,S1,S2,S3,v1,v2);
          
        
    end
    
   
    newPop = [Parent; Offspring];%将父代，子代拼接

    [~, so] = sort([newPop.y], 'ascend');%将所有个个体按照升序排列
    newPop = newPop(so);
    
   
    Parent = newPop(1 : nPop);%选择排在前面 nPop个体作为新一代父本
    gt(It)=Parent(1).y;
   
    
 men=mean(gt(1:It));
 disp(['迭代次数', num2str(It), '最小值为', num2str(Parent(1).y)])
% subplot(2,1,1)
addpoints(h0,It,Parent(1).y)

%  plot(It,Parent(1).y,'b.',It,men,'r.')
    
    xlabel('迭代次数')
    ylabel('适应度函数的值')
    title('不同迭代次数下总距离')
    legend({'每代最优解值'})
    pause(0.01)
    hold on
     
end
x=Parent(1).x;
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
figure
title('无人车骑手联合配送路径图')
plot(S0(1)/1000,S0(2)/1000,'ro')
text(S0(1)/1000,S0(2)/1000,'配送中心S')
hold on
plot(S1(1)/1000,S1(2)/1000,'-p')
text(S1(1)/1000,S1(2)/1000,'中转站1')
plot(S2(1)/1000,S2(2)/1000,'rp')
text(S2(1)/1000,S2(2)/1000,'中转站2')
plot(S3(1)/1000,S3(2)/1000,'rp')

text(S3(1)/1000,S3(2)/1000,'中转站3')
title('无人车骑手联合配送图')
xlabel('横坐标/km')
ylabel('纵坐标/km')

for i=1:length(x)
    t=x(i).x;
    h0=animatedline(S0(1)/1000,S0(2)/1000,'color',[rand rand rand]);
    hold on
    for j=2:length(t)
        if t(j)==0.1
            addpoints(h0,S1(1)/1000,S1(2)/1000)
        elseif t(j)==0.2
            addpoints(h0,S2(1)/1000,S2(2)/1000)
        elseif t(j)==0.3
            
            addpoints(h0,S3(1)/1000,S3(2)/1000)
        elseif t(j)>0.3
            addpoints(h0,A1(t(j),1)/1000,A1(t(j),2)/1000)
            text(A1(t(j),1)/1000,A1(t(j),2)/1000,num2str(t(j)))
        else
            addpoints(h0,S0(1)/1000,S0(2)/1000)
            
        end
        
    end
    
    
    
    
    
end





for i=1:length(x)
    t=x(i).x;
     As=['无人车',num2str(i),'-'];
    if t(2)>=1
        
        for j=2:length(t)-1
            Bs=['客户',num2str(t(j)),'-'];
            As=[As,Bs];
%         disp(AS)
%         clear As
        end
        Bs=['无人车',num2str(i)];
            As=[As,Bs];
        
        
    else
        
         As=['无人车',num2str(i),'-','中心站',num2str(t(2)*10),'-'];
       for j=3:length(t)-1
            Bs=['客户',num2str(t(j)),'-'];
            As=[As,Bs];
%         disp(AS)
%         clear As
        end 
    Bs=['中心站',num2str(t(2)*10)];
    As=[As,Bs];
    end
    
    
    
     disp(As)
      
    
end
disp(['运输总成本',num2str(Z1)])
disp(['客户不满意度',num2str(Z2)])




