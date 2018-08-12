import QtQuick 2.0

import "../material"

Item {
    anchors.fill: parent
    id: applytransaction
    objectName: "applytransaction"

    signal signVpn(var id,
        var key)

    FontLoader {
        id: boldfont;source: "../material/fonts/another/Fontfabric-Intro-Black.otf"
    }
    Column {
        spacing: 15
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Your private key"
            color: "#1d4b5a"
            font.family: boldfont.name
            opacity: 0.87
            font.pixelSize: 24
            font.letterSpacing: 2
            textFormat: Text.PlainText
        }
        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            height: 50
            width: 290
            border.color: "#1d4b5a"
            border.width: 3
            color: "white"
            TextField {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.leftMargin: 20
                id: key
                value: ""
                hint: ""
            }
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Room id"
            color: "#1d4b5a"
            font.family: boldfont.name
            opacity: 0.87
            font.pixelSize: 24
            font.letterSpacing: 2
            textFormat: Text.PlainText
        }
        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            height: 50
            width: 290
            border.color: "#1d4b5a"
            border.width: 3
            color: "white"
            TextField {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.leftMargin: 20
                id: roomid
                value: ""
                hint: ""
            }
        }
        MyButton {
            anchors.horizontalCenter: parent.horizontalCenter
            id: next
            text: "SIGN"
            targetmouse: nextmouse
            MouseArea {
                hoverEnabled: true
                id: nextmouse
                anchors.fill: parent
                onClicked: {
                    signVpn(roomid.value, key.value)
                }
            }
        }
    }
}