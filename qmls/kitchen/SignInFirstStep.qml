import QtQuick 2.0

import "../material"

Item {
    Column {
        spacing: 15
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        TextField {
            id: textfield
            height: 30
            width: 290
            value: ""
            hint: "Reqired multisig keys number"
        }
        Rectangle {
            color: "#58b7a1"
            height: 2
            width: 290
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
                    if (parseInt(textfield.value) > 0) {
                        signInParent.requiredKeys = parseInt(textfield.value)
                        signInParent.privateKeys = []
                        textfield.value = ""
                        loader.source = "SignInSecondStep.qml"
                    }
                }
            }
        }
    }
}