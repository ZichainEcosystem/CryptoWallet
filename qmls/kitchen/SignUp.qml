import QtQuick 2.0

import "../material"

Item {
    function getRandomInt(min, max) {
        return Math.floor(Math.random() * (max - min)) + min;
    }
    property int tg_id: getRandomInt(100000, 999999)
    id: signUpParent
    objectName: "signUpParent"
    property int totalKeys: 0
    property int requiredKeys: 0
    property
    var privateKeys: []
    property bool isSolo: false

    signal signUpWallet(int total, int required, int tg_id)

    function setPrivateKeys(keys) {
        privateKeys = keys
        loader.source = "SignUpSecondStep.qml"
    }
    Column {
        spacing: 15
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        MyButton {
            id: solobutton
            text: "SOLO"
            targetmouse: solobuttonmouse
            MouseArea {
                hoverEnabled: true
                id: solobuttonmouse
                anchors.fill: parent
                onClicked: {
                    signUpParent.signUpWallet(1, 1, 0)
                    signUpParent.totalKeys = 1
                    signUpParent.requiredKeys = 1
                    multisigbutton.visible = false
                    solobutton.visible = false
                    signUpParent.isSolo = true
                }
            }
        }
        MyButton {
            color: "gray"
            visible: true
            id: multisigbutton
            text: "MULTI"
            targetmouse: multisigbuttonmouse
            MouseArea {
                hoverEnabled: false
                id: multisigbuttonmouse
                anchors.fill: parent
                onClicked: {
//                    loader.source = "SignUpFirstStep.qml"
//                    multisigbutton.visible = false
//                    solobutton.visible = false
//                    signUpParent.isSolo = false
                }
            }
        }
    }

    Loader {
        id: loader
        anchors.fill: parent
    }

    anchors.fill: parent

}