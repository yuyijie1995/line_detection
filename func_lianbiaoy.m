function [ select_point ] = func_lianbiaoy( imag )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

select_point=zeros(1,2);
select_point_cow=1;
[high,width] = size(imag);%imag的宽高

for i=1:high
     j=1;
%      quit=false;
     while(imag(i,j)==0)
              while (imag(i,j)==0&&(j<width))%judge1
                   j=j+1;
              end
               judge1=j;

              while (imag(i,j)==255&&(j<width))%judge2
                  j=j+1;
              end

              while (imag(i,j)==0&&(j<width))%judge3
                   j=j+1;
              end
              judge3=j;

              while (imag(i,j)==255&&(j<width))%judge4
                     j=j+1;
              end
              judge4=j;

              judge4=j;
              if(judge3-judge1<30)&&(judge4-judge1>15)
                  select_point(select_point_cow,1)=judge1;
                  select_point(select_point_cow,2)=i;
                  select_point_cow=select_point_cow+1;
                  quit=true;
                  break;
              end
              if(j==width)
                   break;
              end
     end
end
[high,width] = size(select_point);%链表的宽高
      
end

