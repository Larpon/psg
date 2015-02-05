import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

Item {
    width: 640
    height: 480
    property alias captureItem: captureItem
    property alias captureButton: captureButton

    SplitView {
        id: splitView1

        anchors.fill: parent

        Item {
            id: left

            Layout.minimumWidth: 200


            //anchors.margins: 8

            ColumnLayout {
                id: columnLayout1
                anchors.fill: parent

                Button {
                    id: captureButton
                    text: qsTr("Capture")
                }

                Text {
                    id: text1
                    width: 184
                    height: 24
                    text: qsTr("Text")
                    font.pixelSize: 12
                }


                Text {
                    id: text2
                    text: qsTr("Text")
                    font.pixelSize: 12
                }


                ListView {
                    id: listView1
                    x: 0
                    y: 0
                    width: 110
                    height: 160
                    delegate: Item {
                        x: 5
                        width: 80
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

                            onClicked: {
                                var i = modeld.get(index)
                                console.log(i.name)

                                particleLoader.source = i.file
                            }
                        }
                    }
                    model: ListModel {
                        id: modeld
                        ListElement {
                            name: "Explosion"
                            colorCode: "grey"
                            file: "particles/Explosion.qml"
                        }

                        ListElement {
                            name: "Shock wave"
                            colorCode: "red"
                            file: "particles/ShockWave.qml"
                        }

                        ListElement {
                            name: "Smoke"
                            colorCode: "blue"
                            file: "particles/Smoke.qml"
                        }

                        ListElement {
                            name: "Smoke rings"
                            colorCode: "green"
                            file: "particles/SmokeRings.qml"
                        }
                    }
                }

            }
        }

        Item {
            id: item2

            Layout.minimumWidth: 50
            Layout.fillWidth: true


            Rectangle {
                id: rectangle1
                color: "#00000000"
                anchors.fill: parent

                Rectangle {
                    id: rectangle2

                    color: "black"
                    border.color: "#f2ac20"
                    anchors.margins: 10
                    anchors.fill: parent


                    Rectangle {
                        id: captureItem
                        anchors.fill: parent

                        color: "transparent"

                        Loader {
                            anchors.fill: parent
                            id: particleLoader

                        }

                    }
                }
            }


        }
    }

}
