import QtQuick 2.0

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


    signal setInGUI(var list)

    function getButtonList() {
        var buttons = []
        for (var i = 0; i < firstcolumn.children.length; i++)
            buttons.push(firstcolumn.children[i])
        for (var i = 0; i < secondcolumn.children.length; i++)
            buttons.push(secondcolumn.children[i])
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

    Row {
        spacing: 200
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        Row {
            Column {
                y: 13
                spacing: 16
                Title {
                    text: "AUD";font.family: anotherfont.name
                }
                Title {
                    text: "BRL";font.family: anotherfont.name
                }
                Title {
                    text: "CAD";font.family: anotherfont.name
                }
                Title {
                    text: "CNY";font.family: anotherfont.name
                }
                Title {
                    text: "EUR";font.family: anotherfont.name
                }
                Title {
                    text: "GBP";font.family: anotherfont.name
                }
                Title {
                    text: "HKD";font.family: anotherfont.name
                }
                Title {
                    text: "IDR";font.family: anotherfont.name
                }
            }
            Column {
                id: firstcolumn
                Switch {
                    onClicked: setCurrency();value: false;property
                    var target: "AUD"
                }
                Switch {
                    onClicked: setCurrency();value: false;property
                    var target: "BRL"
                }
                Switch {
                    onClicked: setCurrency();value: false;property
                    var target: "CAD"
                }
                Switch {
                    onClicked: setCurrency();value: false;property
                    var target: "CNY"
                }
                Switch {
                    onClicked: setCurrency();value: false;property
                    var target: "EUR"
                }
                Switch {
                    onClicked: setCurrency();value: false;property
                    var target: "GBP"
                }
                Switch {
                    onClicked: setCurrency();value: false;property
                    var target: "HKD"
                }
                Switch {
                    onClicked: setCurrency();value: false;property
                    var target: "IDR"
                }
            }
        }
        Row {
            Column {
                y: 13
                spacing: 16
                Title {
                    text: "INR";font.family: anotherfont.name
                }
                Title {
                    text: "JPY";font.family: anotherfont.name
                }
                Title {
                    text: "KRW";font.family: anotherfont.name
                }
                Title {
                    text: "PLN";font.family: anotherfont.name
                }
                Title {
                    text: "RUB";font.family: anotherfont.name
                }
                Title {
                    text: "TRY";font.family: anotherfont.name
                }
                Title {
                    text: "USD";font.family: anotherfont.name
                }
                Title {
                    text: "ZAR";font.family: anotherfont.name
                }
            }
            Column {
                id: secondcolumn
                Switch {
                    onClicked: setCurrency();value: false;property
                    var target: "INR"
                }
                Switch {
                    onClicked: setCurrency();value: false;property
                    var target: "JPY"
                }
                Switch {
                    onClicked: setCurrency();value: false;property
                    var target: "KRW"
                }
                Switch {
                    onClicked: setCurrency();value: false;property
                    var target: "PLN"
                }
                Switch {
                    onClicked: setCurrency();value: false;property
                    var target: "RUB"
                }
                Switch {
                    onClicked: setCurrency();value: false;property
                    var target: "TRY"
                }
                Switch {
                    onClicked: setCurrency();value: false;property
                    var target: "USD"
                }
                Switch {
                    onClicked: setCurrency();value: false;property
                    var target: "ZAR"
                }
            }
        }
    }
}