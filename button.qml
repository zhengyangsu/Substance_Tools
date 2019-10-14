import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

import "export.js" as Export

 Rectangle {
   id: container
   color: "#323232"
   width: 77
   height: 30
        
Button {
    tooltip: "ExportTex"
    
    style: ButtonStyle {
        
        background: Rectangle {
            id:button
            implicitWidth: 50
            implicitHeight: 26
            anchors.top : parent.top
            anchors.topMargin : 2
            anchors.left : parent.left
            anchors.leftMargin : 2
            
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
            text: "ExportTex"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignBottom
        }
    }
    
        onClicked: {
            Export.exportTex();    
        }
    
        onHoveredChanged: {
            //only fires once - Not working in Painter - QT Bug
        }
    }
}