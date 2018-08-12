import QtQuick 2.0

import "../material"

Item {
    id: signInParent
    objectName: "signInParent"
    property int requiredKeys
    property
    var privateKeys: []
    property bool signinstatus: false
    property bool isSolo: false
    signal logInWallet(var keys)
    signal vpnLogIn(var key,
        var req)

    function callback(status) {
        privateKeys = []
        signinstatus = status
        if (signinstatus) {
            kitchenref.hideSign()
            mainroot.showPrivateKeys(signInParent.isSolo)
            for (var i = 0; i < curencypages.length; i++)
                curencypages[i].showTransaction()
        } else
            loader.source = "SignInResult.qml"
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
                    requiredKeys = 1
                    loader.source = "SignInSecondStep.qml"
                    multisigbutton.visible = false
                    vpnbutton.visible = false
                    solobutton.visible = false
                    loader.visible = true
                    signInParent.isSolo = true
                }
            }
        }
        MyButton {
            color: "gray"
            id: multisigbutton
            text: "MULTI"
            targetmouse: multisigbuttonmouse
            MouseArea {
                hoverEnabled: false
                id: multisigbuttonmouse
                anchors.fill: parent
                onClicked: {
//                    loader.source = "SignInFirstStep.qml"
//                    multisigbutton.visible = false
//                    solobutton.visible = false
//                    vpnbutton.visible = false
//                    loader.visible = true
//                    signInParent.isSolo = false
                }
            }
        }
        MyButton {
            color: "gray"
            id: vpnbutton
            text: "VPN"
            targetmouse: vpnbuttonmouse
            MouseArea {
                hoverEnabled: false
                id: vpnbuttonmouse
                anchors.fill: parent
                onClicked: {
//                    loader.source = "VpnLogIn.qml"
//                    multisigbutton.visible = false
//                    solobutton.visible = false
//                    vpnbutton.visible = false
//                    loader.visible = true
//                    signInParent.isSolo = false
                }
            }
        }
    }
    anchors.fill: parent
    Loader {
        id: loader
        anchors.fill: parent
    }
}