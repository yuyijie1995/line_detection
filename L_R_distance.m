function [u1,v1,u2,v2,biaoqian] = L_R_distance(image)


 
    imag = rgb2gray(image);
    imag = imresize(imag,[480 720]);
    uSobel = func_sobel( imag );
    [a,b]= func_binaryzation(uSobel);
     %[high,width,select_point_y[high width]] = lianbiaoy( b );
  select_point_y = func_lianbiaoy( b ); 
   select_point_z = func_lianbiaoz( a );
   %y=kx+b
   [yx3,yx4,yy3,yy4,yk,yb]=func_hough_selfy(select_point_y);
   [zx3,zx4,zy3,zy4,zk,zb]=func_hough_selfz(select_point_z);
   zy3=zy3+225;
   zy4=zy4+225;
   yy3=yy3+225;
   yy4=yy4+225;
   yx3=yx3+360;
   yx4=yx4+360;
  
  w=imag;%imag_z=imag(high/2-15:high-1,1:width/2)
  w(481:255+480,361:720)=b;
   w(481:255+480,1:360)=a;
  
  imshow(w);
  %imshow(imag);
  hold on;
  scatter(select_point_y(:,1)+360,select_point_y(:,2)+480);

  scatter(select_point_z(:,1),select_point_z(:,2)+480);

  y_points_num = size(select_point_y);
  y_points_num = y_points_num(1);
  
  z_points_num = size(select_point_z);
  z_points_num = z_points_num(1);
  
  if(0.5<yk)&&(yk<3)&&(y_points_num>10)
    plot([yx3,yx4],[yy3,yy4],'g','linewidth',3.5);
    right_lane_good = 1;
  else
       right_lane_good = 0;
  end
  if(-2<zk)&&(zk<-0.5)&&(z_points_num>10)
    plot([zx3,zx4],[zy3,zy4],'g','linewidth',3.5);
    left_lane_good = 1;
  else
    left_lane_good = 0;  
  end
  
 if  (right_lane_good == 1)&&(left_lane_good ==1)
        u1=zx3*1.777;
        v1=zy3*2.133; 
        u2=yx4*1.777;
        v2=yy4*2.133;
        biaoqian = 1;
 end
       
if  (right_lane_good == 1)&&(left_lane_good ==0)
        u1=zx3*1.777;
        v1=zy3*2.133; 
        u2=yx4*1.777;
        v2=yy4*2.133;
        biaoqian = 2;
end
 
if  (right_lane_good == 0)&&(left_lane_good ==1)
        u1=zx3*1.777;
        v1=zy3*2.133; 
        u2=yx4*1.777;
        v2=yy4*2.133;
        biaoqian = 3;
end
 
if  (right_lane_good == 0)&&(left_lane_good ==0)
        u1=zx3*1.777;
        v1=zy3*2.133; 
        u2=yx4*1.777;
        v2=yy4*2.133;
        biaoqian = 4;
end