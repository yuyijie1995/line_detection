function xml_creat_write(dataset,frameNum,data)

filename = dataset;
% create document
docNode = com.mathworks.xml.XMLUtils.createDocument('opencv_storage');
% document element
docRootNode = docNode.getDocumentElement();
% name
nameNode = docNode.createElement(frameNum);
nameNode.appendChild(docNode.createTextNode(sprintf(data)));
docRootNode.appendChild(nameNode);

xmlFileName = [filename,'.xml'];
xmlwrite(xmlFileName,docNode);