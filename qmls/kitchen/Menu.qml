import QtQuick 2.0

import "../material"

Item {
    id: root
    anchors.fill: parent
    property alias content: content_row.children

    property
    var color_start: "#54a793"
    property
    var color_end: "#254f5d"

    MouseArea {
        id: mymouse
        anchors.fill: parent
        enabled: false
    }

    Rectangle {
        id: blur
        anchors.fill: parent
        opacity: 0
        gradient: Gradient {
            GradientStop {
                position: 0.0;color: color_start
            }
            GradientStop {
                position: 1.0;color: color_end
            }
        }
        Behavior on opacity {
            SmoothedAnimation {
                velocity: 2
            }
        }
    }

    Rectangle {
        id: itemlist
        width: 0
        height: root.height
        anchors.right: parent.right
        color: "white"
        Behavior on width {
            SmoothedAnimation {
                velocity: 600
            }
        }

        Flickable {
            id: flck
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 20
            width: content_row.childrenRect.width
            height: content_row.childrenRect.height
            contentWidth: content_row.childrenRect.width;
            contentHeight: content_row.childrenRect.height
            flickableDirection: Flickable.VerticalFlick
            interactive: true

            Column {
                anchors.right: parent.right
                id: content_row
                spacing: 10
            }
        }
        Image {
            scale: imagemouse.containsMouse & !imagemouse.pressed ? 1.1 : 1
            anchors.left: flck.right
            anchors.top: flck.top
            anchors.leftMargin: 30
            anchors.topMargin: 3
            source: "arrowcolor.png"
            MouseArea {
                hoverEnabled: true
                id: imagemouse
                anchors.fill: parent
                onClicked: {
                    root.close_main_menu()
                }
            }
        }
    }

    function show_main_menu() {
        mymouse.enabled = true
        itemlist.width = 300
        blur.opacity = 0.9
    }

    function close_main_menu() {
        blur.opacity = 0
        itemlist.width = 0
        mymouse.enabled = false
    }
}