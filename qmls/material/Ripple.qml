import QtQuick 2.0

Item {
    id: root
    property alias color: ripple.color
    property double ripple_opacity: 0.3
    width: parent.width
    height: width
    x: parent.width / 2
    y: parent.height / 2



    Rectangle {
        id: ripple
        color: p_300
        opacity: 0.0
        scale: 0.3

        x: -parent.width / 2
        y: -parent.width / 2
        width: parent.width
        height: parent.width
        radius: parent.width

        Behavior on scale {
            id: scale_beh;SmoothedAnimation {
                velocity: 3.8
            }
        }
        Behavior on opacity {
            id: op_beh;SmoothedAnimation {
                velocity: 0.7
            }
        }
    }

    function mouse_enter() {
        scale_beh.enabled = false
        op_beh.enabled = false
        ripple.scale = 1.0
        ripple.opacity = root.ripple_opacity
    }

    function mouse_exit() {
        ripple.opacity = 0.0
    }

    function anim() {
        op_beh.enabled = false
        scale_beh.enabled = false
        ripple.scale = 0.3
        ripple.opacity = root.ripple_opacity
        scale_beh.enabled = true
        op_beh.enabled = true
        ripple.scale = 2
        ripple.opacity = 0.0
    }
}