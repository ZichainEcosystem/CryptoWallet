import QtQuick 2.0


Item {
    anchors.right: parent.right
    id: root
    property
    var target
    property string title: "None"
    property string font_path: "../material/fonts/another/Fontfabric-Intro-Black.otf"
    FontLoader {
        id: defaultcolor;source: root.font_path
    }
    property
    var color: "#1d4b5a"
    opacity: mouse.containsMouse ? 1 : 0.7
    height: txt.contentHeight
    width: txt.contentWidth
    clip: false

    Text {
        id: txt
        text: root.title
        color: root.color
        font.family: defaultcolor.name
        font.pixelSize: 20
        font.letterSpacing: 0
        textFormat: Text.PlainText
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            target.show = true
        }
    }
}