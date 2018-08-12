import QtQuick 2.0
import QtQuick.Window 2.2


Item {

    id: root
    property string title
    property alias content: content_itm.children
    property alias actions: actions_row.children
    property alias header: header_content.children
    property bool hide_on_lost: true

    width: 900
    height: clmn.height

    signal cancel()
    z: 24

    Rectangle {
        id: back
        color: "transparent" //"black"
        width: root.parent.width
        height: root.parent.height
        x: -root.parent.x + root.x
        y: -root.parent.y + root.y
        opacity: 0.6

        MouseArea {
            id: mouse
            anchors.fill: parent
            onClicked: {
                if (root.hide_on_lost != false) {
                    root.visible = false;
                }
            }
        }
    }


    Item {
        x: back.x + (back.width - rect.width) / 2
        y: back.y + (back.height - rect.height) / 2

        /*Shadow{
        	target: rect
        	size: 24
        }*/

        Rectangle {
            id: rect
            width: root.width
            height: clmn.height

            color: "transparent" //"white"
            radius: 2


            Rectangle {
                id: color_rect_title
                color: "transparent" //p1_500
                width: parent.width
                height: header_column.height
                radius: 2
            }

            Rectangle {
                color: "transparent" //p1_500
                width: parent.width
                height: 8
                anchors.bottom: color_rect_title.bottom
                visible: color_rect_title.height > 0
            }

            MouseArea {

                anchors.fill: parent
                acceptedButtons: Qt.MiddleButton
                preventStealing: false
                propagateComposedEvents: false
                onClicked: {}
            }


            Column {
                id: clmn
                Column {
                    id: header_column

                    Item {
                        id: title_item
                        width: rect.width
                        height: title_wrap.height + 14

                        visible: title.length > 0
                        Item {
                            id: title_wrap
                            width: rect.width - 48
                            x: 24
                            y: 14
                            height: title_txt.contentHeight + 14


                            Title {
                                id: title_txt
                                color: "white"
                                text: title
                                width: parent.width
                                wrapMode: Text.Wrap
                            }
                        }


                    }
                    Item {
                        id: header_content
                        height: 48
                        width: rect.width
                        visible: root.header.length ? true : false
                    }
                }
                Item {
                    width: 20
                    height: 16
                }

                Item {
                    width: rect.width
                    height: content_itm.height + 24
                    Item {
                        id: content_itm
                        x: 24
                        width: parent.width - 48
                        height: childrenRect.height
                    }
                }

                Item {
                    id: actions
                    width: rect.width
                    height: 50
                    Row {
                        id: actions_row
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 8
                    }
                }
            }
        }
    }
}