function xml_write(dataset,frameNum,data)

filename = dataset;
xmlFileName = [filename,'.xml'];
docNode = xmlread(xmlFileName);
% name

docRootNode = docNode.getDocumentElement();
nameNode = docNode.createElement(frameNum);

nameNode.appendChild(docNode.createTextNode(sprintf(data)));
docRootNode.appendChild(nameNode);


xmlwrite(xmlFileName,docNode);