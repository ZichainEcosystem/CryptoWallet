import QtQuick 2.0

import "../material"

Rectangle {
    id: root
    width: parent.width
    x: show ? 0 : width
    height: parent.height
    property string header: "Label"
    property bool show: false
    property var objectHolder: objHolder
    MouseArea {
        anchors.fill: root
    }
    property string font_path: "../material/fonts/another/Fontfabric-Intro-Black.otf"
    FontLoader {
        id: defaultcolor;source: root.font_path
    }
    FontLoader {
        id: anotherfont;source: "../material/fonts/another/Fontfabric-Intro-Book.otf"
    }
    Image {
        id: close
        scale: closemouse.containsMouse & !closemouse.pressed ? 1.1 : 1
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 40
        anchors.rightMargin: 40
        source: "close.png"
        MouseArea {
            id: closemouse
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                root.show = false
            }
        }
    }
    Text {
        text: root.header
        color: "#1d4b5a"
        font.family: defaultcolor.name
        font.pixelSize: 30
        font.letterSpacing: 0
        textFormat: Text.PlainText
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: 50
        anchors.leftMargin: 40
    }
    Rectangle {
        anchors.top: close.bottom
        anchors.topMargin: 40
        anchors.right: parent.right
        anchors.rightMargin: 40
        anchors.left: parent.left
        anchors.leftMargin: 40
        color: "#dbdbdb"
        height: 2
    }

    property var indexMap: ({})

    function generateTabString(title, i) {
            var string = '
            import QtQuick 2.0;
            import "../material";
            TabItem {
                title: "' + title + '";
                target: objHolder.children[' + i +']
            }
            '
            return string
    }

    function setCurrency(list)
    {
            tabHolder.content = []
            for (var i = 0; i < objHolder.children.length; i++)
                objHolder.children[i].visible = false

            for (var i = 0; i < list.length; i++) {
                var obj = Qt.createQmlObject(generateTabString(list[i], indexMap[list[i]]), tabHolder, list[i])
                tabHolder.content.push(obj)
            }

            tabHolder.set_active(tabHolder.content[0])
            tabHolder.content[0].select_tab()
    }

    Item {
        anchors.fill: parent
        anchors.topMargin: 150

        Tabs {
            id: tabHolder
            anchors.leftMargin: 3
            anchors.rightMargin: 10
            anchors.left: parent.left
            anchors.right: parent.right
            content: []
        }

        Rectangle {
            anchors.rightMargin: 40
            anchors.leftMargin: 40
            anchors.topMargin: 60
            anchors.left: parent.left
            anchors.top: tabHolder.bottom
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            id: objHolder
            color: "transparent"
       }
    }
}