import QtQuick 2.0

import "../material"

Item {
    property int counter: 0
    FontLoader {
        id: boldfont;source: "../material/fonts/another/Fontfabric-Intro-Black.otf"
    }
    Column {
        spacing: 15
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: signInParent.requiredKeys == 1 ? "Your private key" : "Private key by " + (counter + 1) + " person"
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
                id: textfield
                value: ""
                hint: ""
            }
        }
        MyButton {
            anchors.horizontalCenter: parent.horizontalCenter
            id: next
            text: "NEXT"
            targetmouse: nextmouse
            MouseArea {
                hoverEnabled: true
                id: nextmouse
                anchors.fill: parent
                onClicked: {
                    if (textfield.value.length > 0) {
                        signInParent.privateKeys.push(textfield.value)
                        textfield.value = ""
                        if (counter == signInParent.requiredKeys - 1) {
                            signInParent.logInWallet(signInParent.privateKeys)
                        } else {
                            counter++
                        }
                    }
                }
            }
        }
    }
}