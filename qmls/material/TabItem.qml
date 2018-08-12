import QtQuick 2.0




Item {
    id: root
    property string title: "None"
    property bool disabled: false
    property bool active: false
    // property bool colored: parent.colored
    property int tab_size: root.get_indicator_size() //parent.tab_size
    property
    var target


    property string font_path: "fonts/another/Fontfabric-Intro-Book.otf"
    FontLoader {
        id: defaultfont;source: root.font_path
    }
    property
    var color_enabled: "#58b7a1"
    property
    var color_disabled: "#828282"
    property bool uppercase: true
    property int letter_spacing: 3
    property int font_size: 20

    signal clicked()

    width: tab_size
    height: 48

    clip: false




    TextButton {
        y: (parent.height - contentHeight) / 2 - 1
        id: txt
        font.pixelSize: root.font_size
        font.family: defaultfont.name
        font.letterSpacing: root.letter_spacing
        font.capitalization: uppercase ? Font.AllUppercase : Font.MixedCase
        opacity: active ? 1 : mouse.containsMouse ? 1 : 0.7
        text: root.title
        width: root.tab_size
        horizontalAlignment: Text.AlignHCenter
        color: active ? color_enabled : color_disabled
        //y : lineCount > 1 ? 7 : 14
        wrapMode: Text.WordWrap
    }



    Ripple {
        id: ripple
        color: txt.color
        width: 38
        height: 38
        // anchors.centerIn: parent
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        enabled: !disabled
        onClicked: {
            if (!active) {
                root.clicked(root)
                select_tab()
                root.active = true
                ripple.anim()
            }


        }
    }

    Component.onCompleted: {
        if (target) {
            target.visible = false
        }
        if (active) {
            select_tab()
        }
    }

    function select_tab() {
        parent.on_select(root)
        root.active = true
        if (target) {
            target.visible = true
        }
    }

    function hide() {
        root.active = false
        if (target) {
            target.visible = false
        }
    }

    function get_indicator_size() {
        return txt.contentWidth
    }
}