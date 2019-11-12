/*Substance Painter Export Maps
#Version: 1.0.0
#Update: 
#Description: Substance Painter plugin for batch exporting maps

#Contact: 
*/

//Note: you only need '.pragma library' if you are planning to
//change this variable from multiple qml files
.pragma library

//var declare
var res = "";
var docSize = "";
var dir = "";
var format = "";
var preSet = "";
var depth = "";
var udims = {};
var structure = "";
var resources = "";
var numOfUdim  = 0;
var customChannelsCount = 0;

//Log to console
function log(msg, mode) {
    
    switch(mode) {
     case "info":
        alg.log.info(msg);
      break;
     case "warn":
        alg.log.warn(msg);
        break;
     case "error":
        alg.log.error(msg);    
        break;
     }
}


//Initialization
function init() {

  resources = alg.resources.documentResources();
  structure = alg.mapexport.documentStructure();
  //alg.log.info(structure);
  alg.log.info("Resources used inside the project: "+ resources.length);

  genExportUdimList();
  udimCount();
  // for(var i = 0; i < resources.length; ++i) {
  //   alg.log.info("name: " + resources[i].name);
  // }

  //alg.log.info(alg.resources.getResourceInfo(resourceInfo.export));

}


//Helper
function setValues(){
  
  res = "Document Resolution";
  docSize = [1024, 1024];
  dir = "C:/Users/ZHENG/Documents/Allegorithmic/Substance Painter/export/test";
  format = "tiff";
  preSet = "PBR MetalRough";
  depth = 16;
  customChannelsCount = 0;
}


function getDocSize(){
   //alg.log.info(alg.mapexport.documentStructure());
   for (var m in structure.materials){
    //alg.log.info(structure.materials[m]);
    var textureSet = structure.materials[m]["name"];
    var selected = structure.materials[m]["selected"];
    if (selected == true){
      docSize = alg.mapexport.textureSetResolution(textureSet);
      alg.log.info("texture_set selected: " + textureSet);
      alg.log.info("texture_set resolution: " + docSize);
    }
   }
}


function genExportUdimList(){
  for (var m in structure.materials){
    //alg.log.info(structure.materials[m]);
    var textureSet = structure.materials[m]["name"];
    //udim export list
    //alg.log.info("textureSet: " + textureSet);
    udims[textureSet] = {udim: textureSet, isChecked: true};
    //alg.log.info(udims[textureSet]);
    alg.log.info("UDIM: "+ udims[textureSet]["udim"] + " Checked:  " + udims[textureSet]["isChecked"]);
  }
}



function toggleExportList(key){

  alg.log.info("toggle");

  if (udims[key]["isChecked"] == true){
    udims[key]["isChecked"] =  false;
    
  }else{

    udims[key]["isChecked"] = true;

  }
  alg.log.info("udim: " + udims[key]["udim"]);
  alg.log.info("isChecked: " + udims[key]["isChecked"]);

}

function getModel(){
  alg.log.info("Model Exported");
  return udims;
}


//function was called before the main.qml 
function udimCount(){
    alg.log.info("udimCount: " + Object.keys(udims).length);
    return Object.keys(udims).length;
}

function getStackPaths(){
  var stackPaths = [];
  for (var key in udims){
    if(udims[key]["isChecked"]){
      stackPaths.push(key);
    }
  }
  alg.log.info(stackPaths);

  return stackPaths;
}

//helpers end


//Eport all texture sets 
function exportTex() {


  getDocSize();
  var stackPaths = getStackPaths();

  alg.log.info(alg.mapexport.exportPath());
  alg.log.info("format: " + format);
  alg.log.info("res: " + res);
  alg.log.info("bitDepth: " + depth);
  alg.log.info("preSet: " + preSet );


  try {
    if (res == "Document Resolution"){

      alg.log.info(alg.mapexport.exportDocumentMaps(preSet,dir,format,{resolution:docSize, bitDepth:Number(depth)},stackPaths));

    }
    else{

      alg.log.info(alg.mapexport.exportDocumentMaps(preSet,dir,format,{resolution:[Number(res), Number(res)], bitDepth:Number(depth)}, stackPaths));

    }
    
  }
  catch (error) {
   log(error, "error");
  }
  

}


function addCustomChannels(){
  //two consideration
  //first max user channels is 8 from 0 to 7
  //second channel name and bitdepth
  if (customChannelsCount < 8) {
    for (var m in structure.materials){
      var textureSet = structure.materials[m]["name"];
      var chanelName = "user" + customChannelsCount;
      alg.texturesets.addChannel(textureSet, chanelName, "L16F");
    }
    customChannelsCount++;
  }else {
    alg.log.warn("max custom user channel reached, self-destruction in 3 seconds.");
  }

}
