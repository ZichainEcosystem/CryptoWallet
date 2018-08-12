import QtQuick 2.2

import "../material"

Rectangle {
    id: root
    width: parent.width
    x: show ? 0 : width
    height: parent.height
    property string header: "Label"
    property bool show: false
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


    function generateButtonString(target, text)
    {
        var string = '
            import QtQuick 2.0;
            import "../material"
            Row{
                property var target: "' + target + '"
                property alias value: btnsw.value
                Title{
                    y: 11
                    text: "' + text + '";
                    font.family: anotherfont.name
                }
                Switch{
                    id: btnsw
                    onClicked: setCurrency();
                    value: false;
                }
            }
        '
        return string
    }

    //array: [[name, bueautifullName]]
    function setCurrencyList(list)
    {
        for (var i = 0; i < list.length; i++)
        {
            var string = generateButtonString(list[i][0], list[i][1])
            var obj = Qt.createQmlObject(string, grid)
        }
    }

    signal setInGUI(var list)

    function getButtonList() {
        var buttons = []
        for (var i = 0; i < grid.children.length; i++)
            buttons.push(grid.children[i])
        return buttons
    }

    function loadList(list) {
        var buttons = getButtonList()
        for (var i = 0; i < buttons.length; i++) {
            var activate = false
            for (var j = 0; j < list.length; j++)
                if (buttons[i].target == list[j]) {
                    activate = true
                    break
                }
            buttons[i].value = activate
        }
        setCurrency()
    }

    function getEnabledCurrency() {
        var cur = []
        var buttons = getButtonList()
        for (var i = 0; i < buttons.length; i++) {
            if (buttons[i].value == false)
                continue;
            cur.push(buttons[i].target)
        }
        return cur
    }

    function setCurrency() {
        var cur = getEnabledCurrency()
        setInGUI(cur)
    }

    Grid
    {
        horizontalItemAlignment: Grid.AlignRight
        id: grid
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        columns: 3
        spacing: 30
    }
}