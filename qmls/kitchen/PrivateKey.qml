//import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick 2.6
import QtQuick.Controls 2.1
import "../material"

Rectangle {
    FontLoader {
        id: defaultfont;source: "../material/fonts/another/Fontfabric-Intro-Book.otf"
    }
    FontLoader {
        id: boldfont;source: "../material/fonts/another/Fontfabric-Intro-Black.otf"
    }
    color: "transparent"

    id: root
    property var ref
    property var longName: ref.objectName
    property var balance: ref.balance
    property var shortName: ref.shortName
    property var privateKey: ref.privateKey
    anchors.fill: parent


    Rectangle {
        color: "transparent"
        anchors.fill: parent
        Column {
            id: column
            width: parent.width
            spacing: 10
            anchors.top: parent.top
            anchors.topMargin: (parent.height - 555) / 2
            anchors.horizontalCenter: parent.horizontalCenter
            Text {
                width: parent.width
                text: "Below is you private key. You will also find your other balances. These should not be used as your primary bacup. For that, use your Backup Phrase."
                color: "#2d2d2d"
                font.family: defaultfont.name
                opacity: 0.87
                font.pixelSize: 16
                font.letterSpacing: 0
                //font.capitalization: Font.AllUppercase
                textFormat: Text.PlainText
                wrapMode: Text.WordWrap
            }
            Text {
                text: root.shortName
                color: "#58b7a1"
                font.family: defaultfont.name
                opacity: 1
                font.pixelSize: 20
                font.letterSpacing: 2
                font.capitalization: Font.AllUppercase
                textFormat: Text.PlainText
            }
            Text {
                text: parseFloat(root.balance).toPrecision()
                color: "#2d2d2d"
                font.family: defaultfont.name
                opacity: 1
                font.pixelSize: 40
                font.letterSpacing: 2
                font.capitalization: Font.AllUppercase
                textFormat: Text.PlainText
            }
            Rectangle {
                color: "#dbdbdb"
                height: 2
                width: parent.width
            }
            Text {
                text: "Your private key"
                color: "#58b7a1"
                font.family: defaultfont.name
                opacity: 0.87
                font.pixelSize: 20
                font.letterSpacing: 2
                textFormat: Text.PlainText
            }
            Row {
                spacing: 5
                Text {
                    width: column.width - 20
                    text: root.privateKey
                    color: "#2d2d2d"
                    font.family: defaultfont.name
                    opacity: 0.87
                    font.pixelSize: 20
                    font.letterSpacing: 0
                    textFormat: Text.PlainText
                    wrapMode: Text.WrapAnywhere
                }
                Image {
                    id: copyimg
                    scale: imagemouse.containsMouse & !imagemouse.pressed ? 1.1 : 1
                    source: "copy.png"
                    MouseArea {
                        hoverEnabled: true
                        id: imagemouse
                        anchors.fill: parent
                        onClicked: {
                            clipboard.copyToClipboard(root.privateKey)
                        }
                    }
                    Behavior on scale {
                        SmoothedAnimation {
                            velocity: 1
                        }
                    }
                }
            }
        }
    }
}