import QtQuick.Layouts 1.3
import QtQuick 2.6
//import QtQuick.Controls 1.4
import QtQuick.Controls 2.3
import "../material"

Rectangle {
    FontLoader {
        id: defaultfont;source: "../material/fonts/another/Fontfabric-Intro-Book.otf"
    }
    FontLoader {
        id: boldfont;source: "../material/fonts/another/Fontfabric-Intro-Black.otf"
    }
    color: "transparent"

    id: root
    anchors.fill: parent

    function updateHistory(data)
    {
        listModel.clear()
        for (var i = 0; i < data.length; i++)
                listModel.append(data[i])
    }

    Rectangle {
        color: "transparent"
        radius: 20
        anchors.fill: parent
        ScrollView {
            anchors.fill: parent
            ScrollBar.horizontal.interactive: true
            ScrollBar.vertical.interactive: true

            ListView {
                model: ListModel {
                    id: listModel
//                    ListElement {
//                        day: "Aug 15 2017"
//                        hour: "9:16"
//                        change: "+0.003 ETC"
//                    }
                }
                delegate:
                    Column
                    {
                        spacing: 5
                        height: 50
                        width: root.width;
                        Rectangle {
                            color: "#dbdbdb"
                            height: 2
                            width: parent.width
                        }
                        Rectangle
                        {
                            width: parent.width;
                            height: 40
                            Text {
                                y: 5
                                text: day
                                color: "#2d2d2d"
                                font.family: boldfont.name
                                opacity: 0.5
                                font.pixelSize: 20
                                font.letterSpacing: 0
                                textFormat: Text.PlainText
                            }
                            Text {
                                y: 10
                                x: 140
                                text: hour
                                color: "#2d2d2d"
                                font.family: defaultfont.name
                                opacity: 0.5
                                font.pixelSize: 15
                                font.letterSpacing: 0
                                textFormat: Text.PlainText
                            }
                            Text {
                                y: 8
                                text: change
                                color: "#58b7a1"
                                anchors.right: parent.right
                                font.family: boldfont.name
                                font.pixelSize: 15
                                font.letterSpacing: 0
                                textFormat: Text.PlainText
                            }

                        }
                    }
            }
        }
    }
}