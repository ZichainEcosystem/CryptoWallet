import QtQuick 2.0

import "material"
import "kitchen"


Rectangle {
    signal logout()
    id: mainroot
    objectName: "mainroot"

    function setVersion(prefix, ver) {
        version.title = prefix + ver.toFixed(1)
    }

    function showPrivateKeys(show) {
        privatekeystab.visible = show
    }
    property
    var curencypages: kitchen.tabswithcurrency.objectholderref.children
    property
    var kitchenref: kitchen
    anchors.fill: parent
    Image {
        anchors.fill: parent
        source: "bkg.png"
        fillMode: Image.Tile
    }
    Image {
        x: 50
        y: 35
        source: "logo.png"
    }
    KitchenSink {
        anchors.fill: parent
        id: kitchen
        visible: true
        focus: true
        z: 0
    }
    Item {
        id: clipboard
        signal copyToClipboard(var data)
        objectName: "clipboard"
    }
    Menu {
        id: mainmenu
        content: [
            MenuItem {
                id: privatekeystab;
                visible: false;
                title: "Display Private Keys";
                target: privmanager
            },
            MenuItem {
                title: "History";
                target: historymanager
            },
            MenuItem {
                title: "Wallets";target: settings
            },
            MenuItem {
                title: "Currency";target: converter
            },
            MenuItem {
                visible: false
                id: logoutbutton;title: "Logout";MouseArea {
                    hoverEnabled: false
                    anchors.fill: parent
                    //onClicked: logout()
                }
            },
            MenuItem {
                id: version;title: "";MouseArea {
                    hoverEnabled: false
                    anchors.fill: parent
                    onClicked: Qt.openUrlExternally("http://doublecapital.group/wallet");
                }
            }
        ]
    }
    Rectangle {
        anchors.fill: parent
        anchors.leftMargin: parent.width * 0.4
        color: "transparent"
        CurrencyMenu {
            id: privmanager
            objectName: "privmanager"
            header: "Display Private Keys"
            function createPrivateObjects()
            {
                for (var i = 0; i < curencypages.length; i++)
                {
                    var string = privmanager.generatePrivateString(i);
                    Qt.createQmlObject(string, objectHolder)
                    privmanager.indexMap[curencypages[i].objectName] = i
                }
            }
            function generatePrivateString(index)
            {
                var string = '
                    import "kitchen"
                    PrivateKey {
                        visible: false
                        ref: curencypages[' + index + ']
                    }
                '
                return string
            }
        }
        CurrencyMenu {
            id: historymanager
            objectName: "historymanager"
            header: "History"
            function createHistoryObjects()
            {
                for (var i = 0; i < curencypages.length; i++)
                {
                    var string = historymanager.generateHistoryString("history" + curencypages[i].objectName);
                    Qt.createQmlObject(string, objectHolder)
                    historymanager.indexMap[curencypages[i].objectName] = i
                }
            }
            function generateHistoryString(name)
            {
                var string = '
                    import "kitchen"
                    History {
                        visible: false
                        objectName: "' + name + '"
                    }
                '
                return string
            }
        }
        Wallets {
            id: settings
            objectName: "settings"
            header: "Wallets"
        }
        Converter {
            id: converter
            objectName: "converter"
            header: "Currency"
        }
    }
}