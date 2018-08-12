import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: root
    property string path: "icons/folder.svg"
    property color color: "black"
    width: 24
    height: 24

    Rectangle {
        width: root.width
        height: root.height
        color: root.color
        id: icon
        visible: false
    }
    Image {
        id: mask
        source: path
        visible: false
        smooth: false
    }
    OpacityMask {
        width: root.width
        height: root.height
        source: icon
        maskSource: mask
    }


}