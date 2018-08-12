import QtQuick 2.0

Item {
    id: root
    width: parent.width
    height: clmn.childrenRect.height

    FontLoader {
        id: hintfont;source: root.hint_font_path
    }
    FontLoader {
        id: valuefont;source: root.value_font_path
    }

    property string hint_font_path: "fonts/another/Fontfabric-Intro-Black.otf"
    property string value_font_path: "fonts/another/Fontfabric-Intro-Book.otf"
    property bool stand: false
    property int size: 20
    property alias value: txt.text
    property string label: ""
    property bool is_error: false
    property bool disabled: false
    property alias hint: txt_hint.text
    property alias error_message: txt_error.text
    property bool multiline: false
    property string icon: ""

    Item {
        width: 48
        height: 48
        y: label.length > 0 ? 16 : 0
        Icon {
            width: 24
            height: 24
            x: 12
            y: 12
            path: root.icon
            color: txt.activeFocus ? p1_500 : "black"
            opacity: txt.activeFocus ? 1 : 0.54
        }
        visible: icon.length
    }

    Column {
        x: icon.length ? 68 : 0
        id: clmn
        Item {
            visible: label.length > 0
            width: root.width - clmn.x
            height: 20

            Text {
                text: "Label"
                font.pixelSize: txt.activeFocus || txt.text.length ? 12 : 16
                y: txt.activeFocus || txt.text.length ? 14 : 32
                color: "black"
                opacity: 0.38
                Behavior on y {
                    SmoothedAnimation {
                        velocity: 120
                    }
                }
                Behavior on font.pixelSize {
                    SmoothedAnimation {
                        velocity: 26
                    }
                }

            }
        }
        Item {
            width: root.width - clmn.x
            height: txt.height + 28
            clip: true

            Text {
                id: txt_hint
                y: 12
                font.family: hintfont.name
                font.pixelSize: root.size
                visible: !root.label && !root.value.length
                opacity: 0.26
            }
            TextEdit {
                id: txt
                font.family: valuefont.name
                width: root.width - clmn.x
                y: 12
                height: lineCount * 19
                text: root.value
                font.pixelSize: root.size
                focus: true
                wrapMode: root.multiline ? TextEdit.Wrap : TextEdit.NoWrap
                enabled: !root.disabled
                opacity: root.disabled ? 0.26 : 0.87

                cursorDelegate: Rectangle {
                    width: 2
                    height: 16
                    color: root.is_error ? p2_500 : p1_500
                    visible: txt.activeFocus

                    NumberAnimation on opacity {
                        id: cursor_blink_anim
                        from: 6.0
                        to: -6.0
                        duration: 3000
                        loops: -1
                    }
                    onXChanged: cursor_blink_anim.restart()
                }

                onCursorRectangleChanged: ensureVisible(cursorRectangle)

                function ensureVisible(r) {
                    txt.x = r.x < txt.width ? 0 : txt.width - r.x - 2
                }
            }

            Rectangle {
                y: txt.y + txt.height + 8
                width: root.width - clmn.x
                height: txt.activeFocus ? 2 : 1
                color: root.is_error ? p2_500 : txt.activeFocus ? p1_500 : "black"
                opacity: root.is_error ? 1 : txt.activeFocus ? 1 : 0.12
                visible: root.stand
            }


        }
        Item {
            width: 20
            height: 20
            Text {
                id: txt_error
                text: ""
                y: -4
                height: 10
                visible: root.is_error
                color: p2_500
                font.pixelSize: 12
            }
        }
    }
}