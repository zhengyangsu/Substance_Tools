import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQml 2.2
import AlgWidgets 2.0

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
                    model: [ "png", "tga", "jpg", "bmp", "tiff", "exr" ]
                    
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

//image format
       Item {
         id: preset
         anchors.left: parent.left
         anchors.leftMargin: 5
         y: 165
                    
            Text {
              id:presetText
              text: "Export preset"
              color: "white"
             
               


                AlgTextInput {
                  id:presetOptions
                  width: 200
                  text: "PBR MetalRough"
                  anchors.left: parent.left
                  anchors.top: parent.bottom
                  color: "#151515"; selectionColor: "#0FA4D6"
                  backgroundColor: "white"
                  focus: true

                  Connections{
                    onTextEdited: {
                    alg.log.info("Text changed");
                    Export.preSet = presetOptions.getText(0,presetOptions.length);
                    alg.log.warn("edited: " + focus);
                    }
                  }
                }
            }       
        }

// file dialog - Export Maps 
        Item {
          id: browse
          anchors.left: parent.left
          anchors.leftMargin: 5
          y:215
          
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

        Item {
          id: createChanel
          anchors.left: parent.left
          anchors.leftMargin: 5
          y:255
          
           Button {
            id: customChanel   
            style: ButtonStyle {
                background: Rectangle {
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
                    text: "Add User Channel"
                    anchors.leftMargin : 10
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignBottom 
               } 
            }
            
            onClicked: {
                Export.addCustomChannels()
            }
          }
       }
      
      ListModel {
        id: documentStructureModel

        Component.onCompleted: {
        documentStructureModel.clear()
        var temp = Export.getModel()

          alg.log.info("model length count: " + temp.count)

          for (var key in temp){
            alg.log.info("temp: " + temp[key]["udim"] + " " + temp[key]["isChecked"])
            documentStructureModel.append(temp[key])
            alg.log.info("documentStructureModel: " + documentStructureModel[key])
          }
        }
      }

      ColumnLayout {
        y:295
        anchors.left: parent.left
        anchors.leftMargin: 5

        RowLayout {
          id: controlButtons
          anchors.top: parent.top
          anchors.left: parent.left; anchors.right: parent.right
          spacing: 6
          layoutDirection: Qt.RightToLeft

          Button {
            id: noneButton   
            style: ButtonStyle {
                background: Rectangle {
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
                    text: "None"
                    anchors.leftMargin : 10
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignBottom 
               } 
              }
            }

            Button {
            id: allButton   
            style: ButtonStyle {
                background: Rectangle {
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
                    text: "All"
                    anchors.leftMargin : 10
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignBottom 
               } 
              }
            }         
        }


        AlgScrollView {
          id:  scrollView
          width: 125
          height: 300
          Column {
                Repeater {
                  model: documentStructureModel
                  RowLayout{
                    id: rowItem
                    spacing: 12
                    property alias checked: modelCheckBox.checked
                    signal clicked()

                    AlgCheckBox {

                      id: modelCheckBox
                      checked: true
                      Layout.preferredWidth: height
                      


                      onCheckedChanged: {
                      Export.toggleExportList(udim);
                      }

                      onClicked: {
                        rowItem.clicked()
                      }

                      Connections {
                        target: noneButton
                        onClicked: {
                           checked = false
                        }
                      }

                      Connections {
                        target: allButton
                        onClicked: {
                           checked = true
                        }
                      }

                    }

                    AlgTextEdit {
                      readOnly: true
                      borderActivated: true
                      borderOpacity: 0.3
                      Layout.fillWidth: true
                      text: udim
                    }
                  
                  }
                }
          }
}



      }

  }   
}