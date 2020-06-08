function  LaneDetection(datapath)  


    dis_result_pre = [num2str(188) num2str(188)];
    %读取xml文件，获得标定信息。
    calib_file = ['C:\Users\Administrator\Desktop\样例数据4-车道偏离监测任务\TSD-LDM-Info\',datapath,'-Info.xml'];
    xmlDoc = xmlread(calib_file);

    %读入矩阵
    histstring =char(xmlDoc.getElementsByTagName('data').item(0).getFirstChild.getData);

    %将char类型转为数字类型
    t = abs(histstring) == 10; % 找到换行的ascii码
    histstring(t) = ' '; % 替换成空格
    hists = str2num( histstring);
    last = reshape(hists,3,3);
    last = last'
    camera_matrix = last;
    
    %读入矩阵
    histstring =char(xmlDoc.getElementsByTagName('data').item(2).getFirstChild.getData);
    %对矩阵进行处理，得到原来的矩阵

    %将char类型转为数字类型
    t = abs(histstring) == 10; % 找到换行的ascii码
    histstring(t) = ' '; % 替换成空格
    hists = str2num( histstring);
    last = reshape(hists,3,3);
    last = last'
    rotation_matrix  = last
    
    %读入矩阵
    histstring =char(xmlDoc.getElementsByTagName('data').item(3).getFirstChild.getData);
    %对矩阵进行处理，得到原来的矩阵

    %将char类型转为数字类型
    t = abs(histstring) == 10; % 找到换行的ascii码
    histstring(t) = ' '; % 替换成空格
    hists = str2num( histstring);
    translation_vector = hists'
    
    whole_matrix = camera_matrix*[rotation_matrix translation_vector];
    %标定信息获取完毕。
    
    %以下开始图像处理
    for img_num = 0:49
        img_path = ['C:\Users\Administrator\Desktop\样例数据4-车道偏离监测任务\TSD-LDM\',datapath,'\',datapath,'-',num2str(img_num,'%05d'),'.png'];
        img = imread (img_path);
        
      
       [u1,v1,u2,v2,biaoqian] = L_R_distance(img);
        
        

        A=[u1*whole_matrix(3,1)-whole_matrix(1,1),u1*whole_matrix(3,2)-whole_matrix(1,2);v1*whole_matrix(3,1)-whole_matrix(2,1),v1*whole_matrix(3,2)-whole_matrix(2,2)];
        B=[whole_matrix(1,4)-u1*whole_matrix(3,4),whole_matrix(2,4)-v1*whole_matrix(3,4)]';
        X1=abs(inv(A)*B);
        

        A=[u2*whole_matrix(3,1)-whole_matrix(1,1),u2*whole_matrix(3,2)-whole_matrix(1,2);v2*whole_matrix(3,1)-whole_matrix(2,1),v2*whole_matrix(3,2)-whole_matrix(2,2)];
        B=[whole_matrix(1,4)-u2*whole_matrix(3,4),whole_matrix(2,4)-v2*whole_matrix(3,4)]';
        X2=abs(inv(A)*B);
        biaoqian
        if (biaoqian == 1)
        dis_result = [num2str(X1(2)),' ',num2str(X2(2))];%最终计算出的左右车道线距离。
        dis_result_pre = dis_result;
        end
        if (biaoqian == 2)
        dis_result = [num2str(380-X2(2)),' ',num2str(X2(2))];%最终计算出的左右车道线距离。
        dis_result_pre = dis_result;
        end
        if (biaoqian == 3)
        dis_result = [num2str(X1(2)),' ',num2str(380-X1(2))];%最终计算出的左右车道线距离。
        dis_result_pre = dis_result;
        end
        if (biaoqian == 4)
        dis_result = dis_result_pre;%最终计算出的左右车道线距离。
        end
        

        
        if  img_num == 2%图像为第二张时，创建xml文件
            result_path = [datapath,'-RS'];
            frame_path = ['Frame',num2str(img_num,'%05d')];
            xml_creat_write(result_path,frame_path,dis_result)
        else
            if img_num > 2%图像不为第二张时，写入xml文件
            result_path = [datapath,'-RS'];
            frame_path = ['Frame',num2str(img_num,'%05d')];
            xml_write(result_path,frame_path,dis_result)  
            end
        end
    end

    
   
   
 
    
   









