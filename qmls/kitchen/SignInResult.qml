import QtQuick 2.0

import "../material"

Item {
    Column {
        spacing: 15
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        MyButton {
            visible: !signInParent.signinstatus
            width: 150
            showarrow: false
            anchors.horizontalCenter: parent.horizontalCenter
            text: "TRY AGAIN"
            targetmouse: againmouse
            MouseArea {
                hoverEnabled: true
                id: againmouse
                anchors.fill: parent
                onClicked: {
                    loader.visible = false
                    multisigbutton.visible = true
                    solobutton.visible = true
                    vpnbutton.visible = true
                }
            }
        }
    }
}