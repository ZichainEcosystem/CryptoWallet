import QtQuick 2.0

Item {
    id: root
    property string path
    property bool dark: false
    property color color: p_800
    property bool disabled: false
    property double icon_opacity
    property int size: 24
    signal clicked()

    y: 4
    width: 36
    height: 36
    clip: false

    Ripple {
        id: ripple
        color: root.color
    }

    Icon {
        width: root.size
        height: root.size
        color: root.color
        path: root.path ? root.path : "icons/heart.svg"
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        opacity: root.icon_opacity ? root.icon_opacity : disabled ? 0.25 : 1
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        enabled: !root.disabled
        onClicked: {
            ripple.anim()
            root.clicked()
        }
        onEntered: {
            ripple.mouse_enter()
        }
        onExited: {
            ripple.mouse_exit()
        }
    }
}