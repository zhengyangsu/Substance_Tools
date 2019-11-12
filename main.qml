import QtQuick 2.2
import Painter 1.0
import "export.js" as Export

PainterPlugin {
        // starts a timer that will trigger the 'onTick' callback at regular interval
        tickIntervalMS: -1 // -1 mean disabled (default value)

        // starts a JSON server on the given port:
        // you send javascript that will be evaluated and you get the result in JSON format
        jsonServerPort: -1 // -1 mean disabled (default value)

        Component.onCompleted: {
                // Called after the object has been instantiated.
                // This can be used to execute script code at startup,
                // once the full QML environment has been established.
                Export.init()
                var button = alg.ui.addToolBarWidget("button.qml")//add a button to toolbar
                var dockWidget = alg.ui.addDockWidget("dockWidget.qml")//add dock widget
                Export.setValues()
                Export.log("The God Emperor Protects!", "Channel Export Plugin has been created", "info")
                alg.log.info("Component.onCompleted")
        }

        onTick: {
                // Do something at each tick, depending on tickIntervalMS value
                alg.log.info("onTick")
        }

        onConfigure: {
                // Do something when the user request the plugin configuration panel
                alg.log.info("onConfigure")
        }

        onApplicationStarted: {
                // Called when the application is started
                alg.log.info("onApplicationStarted")
        }

        onNewProjectCreated: {
                // Called when a new project is created, before the onProjectOpened callback
                alg.log.info("onNewProjectCreated")
        }

        onProjectOpened: {
                // Called when the project is fully loaded
                alg.log.info("onProjectOpened")
        }

        onProjectAboutToClose: {
                // Called before project unload
                alg.log.info("onProjectAboutToClose")
        }

        onProjectAboutToSave: function(destinationUrl) {
                // Called before a save, 'destination_url' parameter contains the save destination
                alg.log.info("onProjectAboutToSave: "+destinationUrl)
        }

        onProjectSaved: {
                // Called after the project was saved
                alg.log.info("onProjectSaved")
        }

        onComputationStatusChanged: function(isComputing) {
                // Called when the state of the engine computing stacks content change.
                // If the stack content is computed, 'isComputing' parameter will be false
                alg.log.info("onComputationStatusChanged: "+isComputing)
        }

        onExportAboutToStart: function(maps) {
                // Called just before the export process starts.
                // 'maps' is the list of filepaths expected to be written.
                alg.log.info("onExportAboutToStart: ")
                for (var stackName in maps) {
                    alg.log.info(stackName);
                    for (var filePath in maps[stackName]) {
                        alg.log.info(maps[stackName][filePath]);
                    }
                }

                // Example:
                // Open the 'PreviewSphere' sample, set 'C:/tmp' as export path, choose 'png' as export
                // format and select the 'PBR MetalRough' config, the example above will output:

                // onExportAboutToStart:
                // Sphere
                // c:/tmp/Sphere_Sphere_BaseColor.png
                // c:/tmp/Sphere_Sphere_Roughness.png
                // c:/tmp/Sphere_Sphere_Metallic.png
                // c:/tmp/Sphere_Sphere_Normal.png
                // c:/tmp/Sphere_Sphere_Height.png

                // Please note the 'Opacity' and 'Emissive' maps are not listed here because they
                // can not be exported with this sample while the actual export will warn about it.
        }

        onExportFinished: function(status, maps) {
                // Called right after the export process ends.
                // 'status' is the error status returned by the process. Available values are:
                // - Export.Status_Ok
                // - Export.Status_Warn
                // - Export.Status_Error
                // - Export.Status_Canceled
                // 'maps' is the list of filepaths effectively exported.
                alg.log.info("onExportFinished: ")
                if (status != Export.Status_Ok) {
                    alg.log.error("Export failed.")
                }
                else {
                    for (var stackName in maps) {
                        alg.log.info(stackName);
                        for (var filePath in maps[stackName]) {
                            alg.log.info(maps[stackName][filePath]);
                        }
                    }
                }
        }

}