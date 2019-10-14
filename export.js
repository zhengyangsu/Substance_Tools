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
  res = "Document Resolution";
  docSize = [1024, 1024];
  dir = "C:/Users/ZHENG/Documents/Allegorithmic/Substance Painter/export/test";
  format = "tiff";
  preSet = "PBR MetalRough";
  depth = 16;
}


//Helper
function getDocSize(){
   //alg.log.info(alg.mapexport.documentStructure());
   var structure = alg.mapexport.documentStructure();
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



//Eport all texture sets 
function exportTex() {


  getDocSize();

  alg.log.info(alg.mapexport.exportPath());
  alg.log.info("format: " + format);
  alg.log.info("res: " + res);
  alg.log.info("bitDepth " + depth);

  try {
    if (res == "Document Resolution"){

      alg.log.info(alg.mapexport.exportDocumentMaps(preSet,dir,format,{resolution:docSize, bitDepth:Number(depth)}));

    }
    else{

      alg.log.info(alg.mapexport.exportDocumentMaps(preSet,dir,format,{resolution:[Number(res), Number(res)], bitDepth:Number(depth)}));

    }
    
  }
  catch (error) {
   log(error, "error");
  }
  

}



