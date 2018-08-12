import QtQuick 2.0



Item {
    id: root
    property bool rigthmode: false
    property alias content: content_row.children
    property
    var selected
    property int minimum: 90
    property int tab_size: calculate_tab_size()
    property color background: p1_500
    property color color: "black"
    property bool transparent: false

    property bool show_arrows: false

    signal tab_changed()

    width: parent.width
    height: 48



    Rectangle {
        width: parent.width
        height: parent.height
        color: "transparent" //root.background
        visible: !root.transparent
    }

    Item {
        x: 24
        width: 24
        height: 48
        visible: root.show_arrows ? flck.visibleArea.xPosition > 0 : false
        IconButton {
            path: "icons/chevron-left.svg"
            color: "#58b7a1"
            onClicked: {
                var x = flck.contentX - root.tab_size / 2
                if (x < 0) {
                    x = 0
                }
                flck.contentX = x
            }
        }
    }
    Item {

        x: parent.width - 24 - 24
        width: 24
        height: 48
        visible: root.show_arrows ? flck.contentX < (flck.contentWidth - flck.width) : false
        IconButton {
            path: "icons/chevron-right.svg"
            color: "#58b7a1"
            onClicked: {
                var x = flck.contentX + root.tab_size / 2
                if (x < (flck.contentX - flck.width)) {
                    x = (flck.contentX - flck.width)
                }
                flck.contentX = x
            }
        }
    }

    Item {
        anchors.right: root.rigthmode ? parent.right : 0
        id: cntn_wrapper
        width: parent.width - 48 - 48 - 12
        height: parent.height
        clip: root.show_arrows
        x: root.show_arrows ? 48 + 12 : 0
        Flickable {
            id: flck
            anchors.fill: parent
            anchors.leftMargin: root.rigthmode ? parent.width - content_row.childrenRect.width : 0
            contentWidth: content_row.childrenRect.width;
            contentHeight: content_row.childrenRect.height
            flickableDirection: Flickable.HorizontalFlick
            interactive: root.show_arrows

            Row {
                id: content_row
                spacing: 20
                property
                var on_select: set_active
                property int tab_size: root.tab_size > minimum ? root.tab_size : minimum
                Behavior on x {
                    SmoothedAnimation {
                        id: smooth_anim;velocity: 400
                    }
                }
            }
            Rectangle {
                id: current_indicator
                width: root.selected ? root.selected.width : 0
                x: root.selected ? root.selected.x + root.selected.width / 2 - width / 2 : 0
                height: 2
                color: "#58b7a1"
                y: content_row.childrenRect.height - height
                //Behavior on x{ SmoothedAnimation{id: lol1; velocity: 1500}}
                Behavior on width {
                    SmoothedAnimation {
                        id: lol2;velocity: 1000
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        if (!root.selected) {
            var first_tab = root.content[0]
            if (first_tab) {
                // set_active(first_tab)
                first_tab.select_tab()
            }

        }
    }

    function calculate_tab_size() {
        if (content_row.childrenRect.width < width) {
            root.show_arrows = false
            return width / content_row.children.length
        }
        root.show_arrows = true
        return (width - 24 - 24 - 24 - 24 - 12) / content_row.children.length
    }

    function set_active(item) {
        if (item != root.selected) {
            if (root.selected) {
                root.selected.hide()
            }
            root.selected = item
            tab_changed(item)
            if (root.show_arrows) {
                if (item.x < flck.contentX) {
                    flck.contentX = item.x
                } else {
                    if ((item.x + item.width) > (flck.contentX + flck.width)) {
                        flck.contentX = item.x - (flck.width - item.width)
                    }
                }
            }
        }
    }
}