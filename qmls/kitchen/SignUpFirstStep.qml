import QtQuick 2.0

import "../material"

Item {
    Column {
        spacing: 15
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        Display1 {
            anchors.horizontalCenter: parent.horizontalCenter
            id: notificationText
            text: ""
        }
        TextField {
            anchors.horizontalCenter: parent.horizontalCenter
            id: textfieldtotal
            height: 30
            width: 290
            value: ""
            hint: "Total multisig keys number"
        }
        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#58b7a1"
            height: 2
            width: 290
        }
        TextField {
            anchors.horizontalCenter: parent.horizontalCenter
            id: textfieldreqired
            height: 30
            width: 290
            value: ""
            hint: "Reqired multisig keys number"
        }
        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
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
                    if (parseInt(textfieldtotal.value) > 0)
                        signUpParent.totalKeys = parseInt(textfieldtotal.value)
                    else
                        signUpParent.totalKeys = 0
                    if (parseInt(textfieldreqired.value) > 0)
                        signUpParent.requiredKeys = parseInt(textfieldreqired.value)
                    else
                        signUpParent.requiredKeys = 0
                    if (signUpParent.requiredKeys <= 0 ||
                        signUpParent.totalKeys <= 0 ||
                        signUpParent.totalKeys < signUpParent.requiredKeys) {
                        notificationText.text = "Number of required keys must be lower or equal than total number"
                    } else {
                        notificationText.text = ""
                        signUpParent.signUpWallet(signUpParent.totalKeys, signUpParent.requiredKeys, signUpParent.tg_id)
                        loader.source = "SignUpTelegramStep.qml"
                    }
                }
            }
        }
    }
}