import QtQuick 2.0

import "../material"

Dialog {
    id: root
    title: "SimpleWallet"
    visible: true
    height: parent.height - 40
    hide_on_lost: false
    property Item tabswithcurrency: tab_content_3
    function hideSign() {
        signin.visible = false
        signup.visible = false
        wallet.visible = true
        balance_tab.visible = true
        head.set_active(wallet)
        wallet.select_tab()
    }

    function calcPrice(cur) {
        var res = 0
        for (var i = 0; i < curencypages.length; i++) {
            var temp = curencypages[i].balance
            if (curencypages[i].courses == undefined)
                continue
            if (isNaN(parseFloat(temp) * curencypages[i].courses[cur]))
                continue
            res = res + parseFloat(temp) * curencypages[i].courses[cur]
        }
        return res
    }
    FontLoader {
        id: boldfont;source: "../material/fonts/another/Fontfabric-Intro-Black.otf"
    }

    // property var current_content : creations_content

    header: Tabs {
        id: head
        anchors.right: parent.right
        anchors.rightMargin: 60
        rigthmode: true
        width: 700
        content: [
            TabItem {
                id: signin;title: "Sign In";font_path: "fonts/another/Fontfabric-Intro-Black.otf";letter_spacing: 0;color_enabled: "#1d4b5a";color_disabled: "#1d4b5a";uppercase: false;target: tab_content_1
            },
            TabItem {
                id: signup;title: "Sign Up";font_path: "fonts/another/Fontfabric-Intro-Black.otf";letter_spacing: 0;color_enabled: "#1d4b5a";color_disabled: "#1d4b5a";uppercase: false;target: tab_content_2
            },
            TabItem {
                id: wallet; visible: false; title: "Wallet";font_path: "fonts/another/Fontfabric-Intro-Black.otf";letter_spacing: 0;color_enabled: "#1d4b5a";color_disabled: "#1d4b5a";uppercase: false;target: tab_content_3
            },
            /*TabItem {
                id: apply;title: "Apply Transaction";font_path: "fonts/another/Fontfabric-Intro-Black.otf";letter_spacing: 0;color_enabled: "#1d4b5a";color_disabled: "#1d4b5a";uppercase: false;target: tab_content_4
            },*/
            TabItem {
                target: tab_content_5
                visible: false;
                id: balance_tab
                y: 11;
                title: "";
                width: bal.width + totalbalancebox.width;
                height: 10;
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text {
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                if (!balance_tab.active) {
                                    balance_tab.clicked(balance_tab)
                                    balance_tab.select_tab()
                                    balance_tab.active = true
                                    balance_tab.ripple.anim()
                                }
                            }
                        }
                        id: bal
                        width: contentWidth
                        text: calcPrice(totalbalancebox.currentText).toFixed(2)
                        color: "#58b7a1"
                        font.family: boldfont.name
                        opacity: 0.87
                        font.pixelSize: 20
                        font.letterSpacing: 0
                        textFormat: Text.PlainText
                        wrapMode: Text.NoWrap
                    }
                    MyComboBox {
                        width: 90
                        id: totalbalancebox
                        objectName: "totalbalancebox"
                        function setList(list) {
                            model = list
                        }
                    }
                }
                font_path: "fonts/another/Fontfabric-Intro-Black.otf";letter_spacing: 0;color_enabled: "#1d4b5a";color_disabled: "#1d4b5a";uppercase: false;
            }
        ]
        Image {
            scale: burgermouse.containsMouse & !burgermouse.pressed ? 1.1 : 1
            anchors.left: parent.right
            anchors.top: parent.top
            anchors.leftMargin: 20
            anchors.topMargin: 15
            source: "burger.png"
            MouseArea {
                id: burgermouse
                hoverEnabled: true
                anchors.fill: parent
                onClicked: {
                    mainmenu.show_main_menu()
                }
            }
        }
    }
    content: Item {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        height: root.height - 100
        width: root.width

        SignIn {
            id: tab_content_1
        }
        SignUp {
            id: tab_content_2
        }
        SampleTabs {
            id: tab_content_3
        }
        ApplyTransaction {
            id: tab_content_4
            visible: false
        }
        Stats {
            id: tab_content_5
        }
    }

    actions: Row {

    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.MiddleButton | Qt.RightMouse
    }
}