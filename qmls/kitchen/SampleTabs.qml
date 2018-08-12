import QtQuick 2.0

import "../material"

Item {
    id: root
    width: parent.width
    height: parent.height
    property var objectholderref: objectholder
    property var indexMap: ({})

    Item {

        function generateTabString(title, i) {
            var string = 'import QtQuick 2.0; import "../material";
            TabItem {
                title: "' + title + '";target: objectholder.children[' + i +']
            }
            '
            return string
        }

        function setCurrency(list) {
            tabholder.content = []
            for (var i = 0; i < objectholder.children.length; i++)
                objectholder.children[i].visible = false

//            var obj = Qt.createQmlObject(generateTabString("settings", "settings"), tabholder, "settings")
//            tabholder.content.push(obj)

            for (var i = 0; i < list.length; i++) {
                var obj = Qt.createQmlObject(generateTabString(list[i], indexMap[list[i]]), tabholder, list[i])
                tabholder.content.push(obj)
            }

            tabholder.set_active(tabholder.content[0])
            tabholder.content[0].select_tab()
        }

        function generateCurrencyString(name, shortName)
        {
            var string = '
                import QtQuick 2.0;
                import "../material";
                Currency {
                    visible: false
                    objectName: "' + name + '"
                    shortName: "' + shortName + '"
                }
            '
            return string
        }

        //array: [[name, shortName]]
        function createCurrencyObjects(list)
        {
            for (var i = 0; i < list.length; i++)
            {
                var string = generateCurrencyString(list[i][0], list[i][1])
                Qt.createQmlObject(string, objectholder)
                indexMap[list[i][0]] = i
            }
        }

        id: objectmanager
        objectName: "objectmanager"
        anchors.fill: parent
        Tabs {
            anchors.leftMargin: 170
            anchors.rightMargin: 170
            anchors.left: parent.left
            anchors.right: parent.right

            id: tabholder
            //content:[TabItem{ title: "Settings"; target: settings}]
        }

        Rectangle {
            color: "transparent"
            id: objectholder
            objectName: "objectholder"
            y: 48
            width: root.width
            height: root.height

            signal sendTransaction(var currency, var address, var amount)

        }
    }
}