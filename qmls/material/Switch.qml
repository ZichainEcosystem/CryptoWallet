import QtQuick 2.0

Item {
    id: root
    property bool value: false
    property bool disabled: false
    property bool dark: false
    signal clicked()

    width: 40
    height: 40


    Item {
        x: 12
        y: 16
        width: 36
        height: 14

        Ripple {
            id: ripple
            x: root.value ? 6 + root.width / 2 : root.width / 2 - 10
            color: track.color
        }

        Rectangle {
            id: track
            anchors.fill: parent
            color: "#54a793" //root.dark? root.disabled ? "white" :root.value ? p1_200 : "white" :   root.disabled ? "black" :root.value ? p1_500 : "black"
            radius: 7
            opacity: root.disabled ? 0.12 : root.value ? 0.5 : 0.26
            Behavior on opacity {
                SmoothedAnimation {
                    velocity: 0.6
                }
            }
        }

        Shadow {
            target: rect_shadow
            size: 8
        }



        Rectangle {
            id: rect_shadow
            anchors.centerIn: handler
            width: 14
            height: 14
            color: "red"
        }
        Rectangle {
            id: handler
            x: root.value ? 16 : 0
            y: -3
            width: 20
            height: 20
            radius: 10
            color: "#254f5d" //root.dark? root.disabled? p_800 :root.value ? p1_200 : p_400    :root.disabled? p_400 :root.value ? p1_500 : p_50

            Behavior on x {
                SmoothedAnimation {
                    velocity: 320
                }
            }
            Behavior on color {
                ColorAnimation {
                    duration: 200
                }
            }
        }

        MouseArea {
            anchors.fill: parent
            enabled: !root.disabled

            onClicked: {
                ripple.anim()
                root.value = !root.value
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


}