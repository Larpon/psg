import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Window 2.0
import QtQuick.Dialogs 1.0

import QtQuick.Particles 2.0

import "qml"
import "qml/ui"

ApplicationWindow {

    id: main

    title: qsTr("Particle Sprite Generator")

    width: 1040
    height: 680

    visible: true

    menuBar: MenuBar {
        Menu {
            title: qsTr("&File")
            MenuItem {
                text: qsTr("&Open")
                onTriggered: messageDialog.show(qsTr("Open action triggered"));
            }
            MenuItem {
                text: qsTr("E&xit")
                onTriggered: Qt.quit();
            }
        }
    }

    MainForm {
        id: mainForm
        anchors.fill: parent

        captureButton.onClicked: {
            grabControl.grab = !grabControl.grab
        }

        backgroundColorButton.onClicked: {
            App.connectOnce(colorDialog.onAccepted,function(){
                captureItemBackground.color = colorDialog.color
            })
            colorDialog.visible = true
        }

        framesListView.model: grabControl.frameModel

    }

    QtObject {
        id: grabControl

        property bool grab: false
        property int frame: frameCountStartFrom

        property Item canvas: mainForm.captureItem
        property ParticleSystem particleSystem

        property int frameCountStartFrom: 0
        property int captureAmount: 1
        property int captureDelay: 1000/parseInt(mainForm.captureFPS.text)

        property ListModel frameModel: ListModel { }

        function captureFrame() {
            if(!grab || !particleSystem)
                return

            particleSystem.pause()

            mainForm.captureItem.grabToImage(function(result) {
                mainForm.captureProgressText.text = 'Grabing frame '+frame

                var filename = "/tmp/frame_"+Util.pad(frame,3,'0')+".png"
                App.debug('Grabing frame',frame,'writing to',filename) //¤

                var saved = result.saveToFile(filename);
                //var resultUrl = result.url
                frame++

                if(saved) {
                    frameModel.append( { frame: frame-1, url: "file://"+filename })
                    if(grab) {
                        if(captureAmount <= 0 || (captureAmount > 0 && frame-frameCountStartFrom < captureAmount)) {
                            particleSystem.resume()
                            App.setTimeout(function(){ // TODO use timer
                                captureFrame()
                            },captureDelay)
                        } else
                            grab = false
                    }
                } else
                   grab = false

            });

        }

        onGrabChanged: {

            if(!grab) {
                frame = frameCountStartFrom
                captureAmount = 1

                mainForm.captureProgressText.text = "Awaiting orders capt'n"
                particleSystem.resume()
                particleSystem = null
                mainForm.captureButton.text = qsTr('Capture')

            } else {
                for (var i=0; i < frameModel.count; i++) {
                    frameModel.get(i).url = ""
                }
                frameModel.clear()

                mainForm.captureProgressText.text = 'Starting capture'
                mainForm.captureButton.text = qsTr('Stop')

                captureAmount = parseInt(mainForm.captureAmountTextField.text)

                App.debug('Capture',captureAmount,'delay',captureDelay) //¤

                Util.loopChildrenDeep(canvas,function(child){
                    App.debug(Util.qtypeof(child)) //¤
                    if(Util.qtypeof(child) === "QQuickParticleSystem")
                        particleSystem = child
                })

                if(particleSystem) {
                    particleSystem.pause()
                    captureFrame()
                }
            }
        }
    }


    ColorDialog {
        id: colorDialog
        title: "Please choose a color"
    }

}
