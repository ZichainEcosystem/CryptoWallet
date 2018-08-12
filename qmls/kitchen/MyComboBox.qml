import QtQuick 2.6
import QtQuick.Controls 2.1

ComboBox {
    FontLoader {
        id: defaultfont;source: "../material/fonts/another/Fontfabric-Intro-Book.otf"
    }
    y: -8
    id: control
    model: ["USD", "CAD", "RUB"]

    delegate: ItemDelegate {
        width: control.width
        contentItem: Text {
            text: modelData
            color: "#58b7a1"
            font.family: defaultfont.name
            font.pixelSize: 15
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
        }
        highlighted: control.highlightedIndex === index
    }

    indicator: Canvas {
        id: canvas
        x: control.width - width - control.rightPadding
        y: control.topPadding + (control.availableHeight - height) / 2
        width: 12
        height: 8
        contextType: "2d"

        Connections {
            target: control
            onPressedChanged: canvas.requestPaint()
        }

        onPaint: {
            context.reset();
            context.moveTo(0, 0);
            context.lineTo(width, 0);
            context.lineTo(width / 2, height);
            context.closePath();
            context.fillStyle = control.pressed ? "#58b7a1" : "#58b7a1";
            context.fill();
        }
    }

    contentItem: Text {
        leftPadding: 13
        rightPadding: control.indicator.width + control.spacing

        text: control.displayText
        font.family: defaultfont.name
        font.pixelSize: 20
        color: control.pressed ? "#58b7a1" : "#58b7a1"
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitWidth: 120
        implicitHeight: 40
        //border.color: control.pressed ? "#58b7a1" : "#58b7a1"
        //border.width: control.visualFocus ? 2 : 1
        color: "transparent"
        radius: 2
    }

    popup: Popup {
        y: control.height - 1
        width: control.width
        implicitHeight: contentItem.implicitHeight
        padding: 1

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: control.popup.visible ? control.delegateModel : null
            currentIndex: control.highlightedIndex

            ScrollIndicator.vertical: ScrollIndicator {}
        }

        background: Rectangle {
            border.color: "#58b7a1"
            radius: 2
            color: "white"
        }
    }
}