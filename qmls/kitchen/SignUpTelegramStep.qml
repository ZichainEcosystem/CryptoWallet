import QtQuick 2.0

import "../material"

Item {
    FontLoader {
        id: boldfont;source: "../material/fonts/another/Fontfabric-Intro-Black.otf"
    }
    Column {
        spacing: 15
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            Text {
                text: "Send to "
                color: "#1d4b5a"
                font.family: boldfont.name
                opacity: 0.87
                font.pixelSize: 24
                font.letterSpacing: 2
                textFormat: Text.PlainText
            }
            Text {
                text: "@DCG_Wallet_bot"
                color: "#1d4b5a"
                font.family: boldfont.name
                opacity: 1
                font.pixelSize: 24
                font.letterSpacing: 2
                textFormat: Text.PlainText
            }
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: signUpParent.tg_id
            color: "#1d4b5a"
            font.family: boldfont.name
            opacity: 0.87
            font.pixelSize: 24
            font.letterSpacing: 2
            textFormat: Text.PlainText
        }
    }
}