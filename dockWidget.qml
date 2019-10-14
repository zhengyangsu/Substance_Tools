import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

import "export.js" as Export

Item {
    id: root
    objectName: "Export Maps"
    
    Rectangle {
       id: rect
       anchors.fill: parent
       color: "#2e2e2e"

//image format
       Item {
         id: imageFormat
         anchors.left: parent.left
         anchors.leftMargin: 5
         y: 15
                    
            Text {
              id:optionText
               text: "Export format"
              color: "white"
                        
                 ComboBox {
                   id: exportItems
                   currentIndex: 0
                   anchors.left: parent.left
                   anchors.top: parent.bottom
                   width: 200
                    model: [ "png", "tga", "jpg", "bmp", "tiff" ]
                    
                     onCurrentIndexChanged: {
                       Export.format = exportItems.textAt(currentIndex)
                   }
                 }
            }
       }

//image format
       Item {
         id: res
         anchors.left: parent.left
         anchors.leftMargin: 5
         y: 65
                    
            Text {
              id:resText
               text: "Export resolution"
              color: "white"
                        
                 ComboBox {
                   id: resOptions
                   currentIndex: 0
                   anchors.left: parent.left
                   anchors.top: parent.bottom
                   width: 200
                    model: [ "Document Resolution","1024", "2048", "4096", "8192" ]
                    
                     onCurrentIndexChanged: {
                      
                      //set resolution
                      Export.res = resOptions.textAt(currentIndex);
                     
                   }
                }
            }
        }       

//image format
       Item {
         id: depth
         anchors.left: parent.left
         anchors.leftMargin: 5
         y: 115
                    
            Text {
              id:depthText
               text: "Export bitDepth"
              color: "white"
                        
                 ComboBox {
                   id: depthOptions
                   currentIndex: 0
                   anchors.left: parent.left
                   anchors.top: parent.bottom
                   width: 200
                    model: [ "8","16", "32" ]
                    
                     onCurrentIndexChanged: {
                      
                      //set bitDepth
                      Export.depth = depthOptions.textAt(currentIndex);
                     
                   }
                }
            }
        }       
       
// file dialog - Export Maps 
        Item {
          id: browse
          anchors.left: parent.left
          anchors.leftMargin: 5
          y:165
          
           Button {
            id: directory   
            style: ButtonStyle {
                background: Rectangle {
                    id:button
                    implicitWidth: 100
                    implicitHeight: 25
                    anchors.top : parent.top
                    anchors.topMargin : 2
                    anchors.left : parent.left
                    anchors.leftMargin : 0
            
                    border.width: 1
                    border.color: "#141414"
                    radius: 2
                    gradient: Gradient {
                    GradientStop { position: 0 ; color: control.pressed ? "#565656" : "#494949" }
                    //GradientStop { position: 0 ; color: control.hovered ? "grey" : "black" }   
                    }
                 }
                label: Text {
                    color: "white"
                    text: "Export Directory "
                    anchors.leftMargin : 10
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignBottom 
               } 
            }
            
            FileDialog {
                id: fileDialog
                selectFolder: true
                title: "Choose a location to save masks"
                folder: shortcuts.documents
                
                onAccepted: {
                    
                    var exportPath = fileDialog.fileUrl.toString();
                    //set path
                    Export.dir = exportPath.replace("file:///", "");
                }
                
                onRejected: {
                    Export.log("Canceled", "warn")
                }
            }
            
            onClicked: {
                fileDialog.open()
            }
          }
       }
    }
}