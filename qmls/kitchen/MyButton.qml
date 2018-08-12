import QtQuick.Layouts 1.3
import QtQuick 2.6
import QtQuick.Controls 2.1
import "../material"


Rectangle {
    property bool showarrow: true
    property
    var targetmouse: mymouse
    property
    var text: "None"
    property alias rowimg: img

    FontLoader {
        id: boldfont;source: "../material/fonts/another/Fontfabric-Intro-Black.otf"
    }
    id: root
    radius: 20
    width: 140
    scale: targetmouse.containsMouse & !targetmouse.pressed ? 1.1 : 1
    height: 40
    color: "#58b7a1"
    Text {
        y: 9
        x: 20
        text: root.text
        color: "white"
        font.family: boldfont.name
        opacity: 0.87
        font.pixelSize: 18
        font.letterSpacing: 2
        textFormat: Text.PlainText
    }
    Image {
        id: img
        visible: root.showarrow
        anchors.verticalCenter: parent.verticalCenter
        x: 100
        source: "arrow.png"
    }
    Behavior on scale {
        SmoothedAnimation {
            velocity: 1
        }
    }
}