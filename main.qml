import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2



import QtQuick.Particles 2.0


ApplicationWindow {

    id: main

    title: qsTr("Particle Sprite Generator")
    width: 640
    height: 480
    visible: true

    property bool grab: false
    property int frame: 0

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
            grab = !grab
        }


    }


    onGrabChanged: {
        if(!grab) {
            frame = 0
            mainForm.captureButton.text = qsTr('Capture')
        } else {
            mainForm.captureButton.text = qsTr('Stop')
        }
    }

    Connections {
        target: main
        onAfterRendering: {

            if(grab) {
                mainForm.captureItem.grabToImage(function(result) {
                    console.log('Grabing frame',frame)
                    result.saveToFile("/tmp/grab_"+frame+".png");
                    frame++
                });
            }
        }

    }







}
