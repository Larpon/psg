import QtQuick 2.0

import QtQuick.Controls 1.0
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0

import ".."

Item {
    width: 640
    height: 480
    property alias captureFPS: captureFPS
    property alias captureAmountTextField: captureAmountTextField

    property alias captureProgressText: captureProgressText
    property alias backgroundColorButton: backgroundColorButton

    property alias captureItem: captureItem
    property alias captureLoadedItem: particleLoader.item
    property alias captureItemBackground: captureItemBackground
    property alias captureButton: captureButton
    property alias framesListView: framesListView

    SplitView {
        id: splitView
        anchors.fill: parent
        orientation: Qt.Vertical


        SplitView {
            id: splitView1
            orientation: Qt.Horizontal

            Layout.fillHeight: true

            Item {
                id: leftPaneItem

                Layout.minimumWidth: columnLayout1.implicitWidth
                Layout.margins: 8
                //anchors.margins: 8

                ColumnLayout {
                    id: columnLayout1

                    anchors.fill: parent

                    RowLayout {

                        Button {
                            id: captureButton
                            text: qsTr("Capture")
                        }

                        TextField {
                            id: captureAmountTextField
                            maximumLength: 4
                        }

                        Label {
                            text: qsTr("frames")
                        }
                    }

                    Row {

                        Label {
                            text: qsTr("fps")
                        }

                        TextField {
                            id: captureFPS
                            text: "60"
                            maximumLength: 4
                        }

                    }

                    Text {
                        id: captureProgressText
                        width: 184
                        height: 24
                        text: qsTr("Text")
                        font.pixelSize: 12
                    }

                    ListView {
                        id: listView1
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        delegate: Item {
                            width: parent.width
                            height: 40

                            Row {
                                id: row1
                                spacing: 10
                                Rectangle {
                                    width: 40
                                    height: 40
                                    color: colorCode
                                }

                                Text {
                                    text: name
                                    anchors.verticalCenter: parent.verticalCenter
                                    font.bold: true
                                }
                            }

                            MouseArea {
                                id: listMouseArea

                                anchors.fill: parent

                                property string particleTemplatePaths: "../../particles/"

                                onClicked: {
                                    var i = modeld.get(index)
                                    console.log(i.name)

                                    particleLoader.source = particleTemplatePaths+i.file
                                }
                            }
                        }
                        model: ListModel {
                            id: modeld

                            ListElement {
                                name: "Explosion"
                                colorCode: "grey"
                                file: "Explosion.qml"
                            }

                            ListElement {
                                name: "Boof"
                                colorCode: "lightgrey"
                                file: "Boof.qml"
                            }

                            ListElement {
                                name: "Shock wave"
                                colorCode: "red"
                                file: "ShockWave.qml"
                            }

                            ListElement {
                                name: "Smoke"
                                colorCode: "blue"
                                file: "Smoke.qml"
                            }

                            ListElement {
                                name: "SmokeSideView"
                                colorCode: "grey"
                                file: "SmokeSideView.qml"
                            }

                            ListElement {
                                name: "Smoke (thick)"
                                colorCode: "black"
                                file: "ThickSmoke.qml"
                            }

                            ListElement {
                                name: "Smoke rings"
                                colorCode: "green"
                                file: "SmokeRings.qml"
                            }

                            ListElement {
                                name: "Smoke trail"
                                colorCode: "grey"
                                file: "SmokeTrail.qml"
                            }

                            ListElement {
                                name: "Camp Fire"
                                colorCode: "yellow"
                                file: "CampFire.qml"
                            }

                            ListElement {
                                name: "Fire"
                                colorCode: "orange"
                                file: "Fire.qml"
                            }

                            ListElement {
                                name: "Portal"
                                colorCode: "white"
                                file: "Portal.qml"
                            }

                        }
                    }

                }
            }


            Item {
                id: item2

                Layout.minimumWidth: 50
                Layout.fillWidth: true

                ColumnLayout {
                    anchors.fill: parent

                    Label {
                        text: qsTr("Frame size %1x%2").arg(particleLoader.width).arg(particleLoader.height)
                        Layout.topMargin: 8
                        Layout.leftMargin: 8
                        Layout.rightMargin: 8
                    }

                    Rectangle {
                        id: captureItemBackground

                        color: "#5e913e"
                        border.color: Qt.darker(Qt.darker(color))

                        Layout.margins: 8
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        Item {
                            id: captureItem
                            anchors.fill: parent

                            // QTBUG-44288 - if using Rectangle instead of Item
                            //color: captureItemBackground.color //"transparent"
                            //color: "transparent"

                            Rectangle {
                                //id: particleLoaderTrick
                                anchors.fill: parent
                                color: captureItemBackground.color
                                //opacity: 0.01
                                //border.color: captureItemBackground.color
                                //border.width: 200
                            }

                            Loader {
                                id: particleLoader
                                anchors.fill: parent
                                scale: particleLoaderScale.value
                                transformOrigin: Item.Center
                            }


                        }

                    }

                }
            }

            Item {
                id: item1

                Layout.minimumWidth: 200

                GroupBox {
                    id: groupBox
                    width: 360
                    height: 300
                    title: qsTr("Canvas")

                    Column {

                        Row {

                            Rectangle { width: 20; height: width; color: captureItemBackground.color }

                            Button {
                                id: backgroundColorButton
                                text: qsTr("Background color")
                            }
                        }

                        Row {

                            Slider {
                                id: particleLoaderScale
                                minimumValue: 0
                                maximumValue: 4
                                value: 1
                            }
                        }
                    }
                }
            }
        }

        ListView {
            id: framesListView
            orientation: ListView.Horizontal
            flickableDirection: Flickable.HorizontalFlick

            Layout.minimumHeight: 140

            cacheBuffer: 0

            model: 0
            delegate: Rectangle {
                id: frameListDelegate
                width: frameListDelegateImage.width
                height: parent.height

                color: captureItemBackground.color

                Image {
                    id: frameListDelegateImage
                    height: parent.height

                    fillMode: Image.PreserveAspectFit

                    source: url

                    Text {
                        anchors { top: parent.top; left: parent.left }

                        text: frame
                        font.bold: true

                        color: Util.colorInvert(frameListDelegate.color)
                    }

                    Rectangle { anchors { fill: parent } color: "transparent"; border.color: Util.colorInvert(frameListDelegate.color); border.width: 2 }

                }


            }
        }
    }

}
