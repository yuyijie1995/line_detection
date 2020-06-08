function  LaneDetection(datapath)  


    dis_result_pre = [num2str(188) num2str(188)];
    %��ȡxml�ļ�����ñ궨��Ϣ��
    calib_file = ['C:\Users\Administrator\Desktop\��������4-����ƫ��������\TSD-LDM-Info\',datapath,'-Info.xml'];
    xmlDoc = xmlread(calib_file);

    %�������
    histstring =char(xmlDoc.getElementsByTagName('data').item(0).getFirstChild.getData);

    %��char����תΪ��������
    t = abs(histstring) == 10; % �ҵ����е�ascii��
    histstring(t) = ' '; % �滻�ɿո�
    hists = str2num( histstring);
    last = reshape(hists,3,3);
    last = last'
    camera_matrix = last;
    
    %�������
    histstring =char(xmlDoc.getElementsByTagName('data').item(2).getFirstChild.getData);
    %�Ծ�����д����õ�ԭ���ľ���

    %��char����תΪ��������
    t = abs(histstring) == 10; % �ҵ����е�ascii��
    histstring(t) = ' '; % �滻�ɿո�
    hists = str2num( histstring);
    last = reshape(hists,3,3);
    last = last'
    rotation_matrix  = last
    
    %�������
    histstring =char(xmlDoc.getElementsByTagName('data').item(3).getFirstChild.getData);
    %�Ծ�����д����õ�ԭ���ľ���

    %��char����תΪ��������
    t = abs(histstring) == 10; % �ҵ����е�ascii��
    histstring(t) = ' '; % �滻�ɿո�
    hists = str2num( histstring);
    translation_vector = hists'
    
    whole_matrix = camera_matrix*[rotation_matrix translation_vector];
    %�궨��Ϣ��ȡ��ϡ�
    
    %���¿�ʼͼ����
    for img_num = 0:49
        img_path = ['C:\Users\Administrator\Desktop\��������4-����ƫ��������\TSD-LDM\',datapath,'\',datapath,'-',num2str(img_num,'%05d'),'.png'];
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
        dis_result = [num2str(X1(2)),' ',num2str(X2(2))];%���ռ���������ҳ����߾��롣
        dis_result_pre = dis_result;
        end
        if (biaoqian == 2)
        dis_result = [num2str(380-X2(2)),' ',num2str(X2(2))];%���ռ���������ҳ����߾��롣
        dis_result_pre = dis_result;
        end
        if (biaoqian == 3)
        dis_result = [num2str(X1(2)),' ',num2str(380-X1(2))];%���ռ���������ҳ����߾��롣
        dis_result_pre = dis_result;
        end
        if (biaoqian == 4)
        dis_result = dis_result_pre;%���ռ���������ҳ����߾��롣
        end
        

        
        if  img_num == 2%ͼ��Ϊ�ڶ���ʱ������xml�ļ�
            result_path = [datapath,'-RS'];
            frame_path = ['Frame',num2str(img_num,'%05d')];
            xml_creat_write(result_path,frame_path,dis_result)
        else
            if img_num > 2%ͼ��Ϊ�ڶ���ʱ��д��xml�ļ�
            result_path = [datapath,'-RS'];
            frame_path = ['Frame',num2str(img_num,'%05d')];
            xml_write(result_path,frame_path,dis_result)  
            end
        end
    end

    
   
   
 
    
   









