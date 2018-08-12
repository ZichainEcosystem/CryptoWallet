import QtQuick.Layouts 1.3
import QtQuick 2.6
//import QtQuick.Controls 1.4
import QtQuick.Controls 2.3
import "../material"

Rectangle {
    FontLoader {
        id: defaultfont;source: "../material/fonts/another/Fontfabric-Intro-Book.otf"
    }
    FontLoader {
        id: boldfont;source: "../material/fonts/another/Fontfabric-Intro-Black.otf"
    }
    color: "transparent"
    property
    var shortName
    id: root
    anchors.fill: parent
    property
    var courses: {}
    property
    var privateKey
    property
    var urlAddress

    function setUrlAddress(address) {
        urlAddress = address
    }

    function setPrivateKey(key) {
        privateKey = key
    }

    function showTransaction() {
        transferbase.visible = true
    }

    function updateQrCode(src) {
        addressasqrcode.update(src)
    }

    function setBalance(val) {
        balance = val
    }

    function setAddress(val) {
        address = val
    }

    function setCourses(dict) {
        courses = dict
    }

    function simpleCheckTransaction(address, amount) {
        if (address.length == 0) {
            transactionResult("Enter reciever address")
            return
        }
        if (amount.length == 0) {
            transactionResult("Enter amount")
            return
        }

        transactionResult("Creating transaction")
        roomidblock.visible = false
        objectholder.sendTransaction(root.objectName, address, amount)
    }

    function transactionResult(result) {
        transactionstatus.text = result
    }

    function setRoomId(id) {
        transactionResult("")
        roomidblock.visible = true
        roomid.text = id
    }

    property
    var balance
    property
    var address

    RowLayout {
        id: base
        anchors.fill: parent
        spacing: 0
        Rectangle {
            color: "transparent"
            id: infobase
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width * 0.5
            Column {
                id: column
                width: parent.width * 0.8
                spacing: 10
                anchors.top: parent.top
                anchors.topMargin: (parent.height - 555) / 2
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    text: shortName
                    color: "#58b7a1"
                    font.family: defaultfont.name
                    opacity: 0.87
                    font.pixelSize: 20
                    font.letterSpacing: 2
                    font.capitalization: Font.AllUppercase
                    textFormat: Text.PlainText
                }
                Text {
                    text: parseFloat(root.balance).toPrecision()
                    color: "#2d2d2d"
                    font.family: defaultfont.name
                    opacity: 0.87
                    font.pixelSize: 40
                    font.letterSpacing: 2
                    font.capitalization: Font.AllUppercase
                    textFormat: Text.PlainText
                }
                Row {
                    Text {
                        id: realbalance
                        width: contentWidth * 1.1
                        text: isNaN((parseFloat(root.balance) * root.courses[currencybox.currentText]).toFixed(2)) ? "0.00" : (parseFloat(root.balance) * root.courses[currencybox.currentText]).toFixed(2)
                        color: "#58b7a1"
                        font.family: defaultfont.name
                        opacity: 0.87
                        font.pixelSize: 20
                        font.letterSpacing: 0
                        textFormat: Text.PlainText
                        wrapMode: Text.WordWrap
                    }
                    MyComboBox {
                        id: currencybox
                        objectName: "currencybox"
                        width: 90
                        function setList(list) {
                            model = list
                        }
                    }
                }
                Rectangle {
                    color: "#dbdbdb"
                    height: 2
                    width: parent.width
                }
                Text {
                    text: "Your current address"
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
                        text: root.address
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
                                clipboard.copyToClipboard(root.address)
                            }
                        }
                        Behavior on scale {
                            SmoothedAnimation {
                                velocity: 1
                            }
                        }
                    }
                }
                Image {
                    scale: historybuttonmouse.containsMouse & !historybuttonmouse.pressed ? 1.05 : 1
                    id: addressasqrcode
                    source: ""
                    cache: false
                    function update(src) {
                        source = src
                    }
                    MouseArea {
                        hoverEnabled: true
                        id: historybuttonmouse
                        anchors.fill: parent
                        onClicked: Qt.openUrlExternally(root.urlAddress);
                    }
                }
            }
        }
        Rectangle {
            color: "transparent"
            id: transferbase
            visible: false
            Layout.fillHeight: true
            Layout.fillWidth: true

            Column {
                id: column1
                width: parent.width * 0.8
                spacing: 15
                anchors.top: parent.verticalCenter
                anchors.topMargin: -140
                anchors.horizontalCenter: parent.horizontalCenter

                Rectangle {
                    id: addressframe
                    radius: 5
                    width: parent.width
                    height: 50
                    border.color: "#1d4b5a"
                    border.width: 3
                    color: "transparent"
                    TextField {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.rightMargin: 20
                        anchors.leftMargin: 20
                        id: recieveraddress
                        value: ""
                        hint: "To address"
                    }
                }
                Rectangle {
                    id: valueframe
                    radius: 5
                    width: parent.width
                    height: 50
                    border.color: "#1d4b5a"
                    border.width: 3
                    color: "transparent"
                    TextField {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.rightMargin: 40
                        anchors.leftMargin: 20
                        id: amounttoreciever
                        value: ""
                        hint: "Amount"
                    }
                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 20
                        scale: clearmouse.containsMouse & !clearmouse.pressed ? 1.1 : 1
                        source: "clear.png"
                        MouseArea {
                            hoverEnabled: true
                            id: clearmouse
                            anchors.fill: parent
                            onClicked: {
                                recieveraddress.value = ""
                                amounttoreciever.value = ""
                                transactionstatus.text = ""
                                roomidblock.visible = false
                            }
                        }
                    }
                }
                Rectangle {
                    id: rectbtn
                    anchors.right: parent.right
                    radius: 20
                    width: 140
                    scale: mymouse.containsMouse & !mymouse.pressed ? 1.1 : 1
                    height: 40
                    color: "#58b7a1"
                    Text {
                        y: 9
                        x: 20
                        text: "SEND"
                        color: "white"
                        font.family: boldfont.name
                        opacity: 0.87
                        font.pixelSize: 18
                        font.letterSpacing: 2
                        textFormat: Text.PlainText
                    }
                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        x: 100
                        source: "arrow.png"
                    }
                    MouseArea {
                        hoverEnabled: true
                        id: mymouse
                        anchors.fill: parent
                        onClicked: simpleCheckTransaction(recieveraddress.value, amounttoreciever.value)
                    }
                    Behavior on scale {
                        SmoothedAnimation {
                            velocity: 1
                        }
                    }
                }
                Text {
                    id: transactionstatus
                    width: parent.width
                    anchors.left: parent.left
                    anchors.leftMargin: (width - contentWidth) / 2
                    text: ""
                    color: "#2d2d2d"
                    font.family: defaultfont.name
                    opacity: 1
                    font.pixelSize: 20
                    font.letterSpacing: 0
                    textFormat: Text.PlainText
                    wrapMode: Text.WordWrap
                }
                Row {
                    id: roomidblock
                    visible: false
                    spacing: 5
                    Text {
                        id: roomid
                        width: column1.width - 20
                        color: "#2d2d2d"
                        text: ""
                        font.family: defaultfont.name
                        opacity: 0.87
                        font.pixelSize: 20
                        font.letterSpacing: 0
                        textFormat: Text.PlainText
                        wrapMode: Text.WrapAnywhere
                    }
                    Image {
                        scale: imagemouse2.containsMouse & !imagemouse2.pressed ? 1.1 : 1
                        source: "copy.png"
                        MouseArea {
                            hoverEnabled: true
                            id: imagemouse2
                            anchors.fill: parent
                            onClicked: {
                                clipboard.copyToClipboard(roomid.text)
                            }
                        }
                        Behavior on scale {
                            SmoothedAnimation {
                                velocity: 1
                            }
                        }
                    }
                }
//                ScrollView {
//                    width: parent.width
//                    height: 200
//                    ScrollBar.horizontal.interactive: true
//                    ScrollBar.vertical.interactive: true
//
//                    ListView {
//                        model: ListModel {
//                            ListElement {
//                                name: "Bill Smith"
//                                number: "555 3264"
//                            }
//                            ListElement {
//                                name: "John Brown"
//                                number: "555 8426"
//                            }
//                            ListElement {
//                                name: "Sam Wise"
//                                number: "555 0473"
//                            }
//
//                        }
//                        delegate: Row {
//                            Text { text: "Name: " + name }
//                            Text { text: " Number: " + number }
//                        }
//                    }
//                }
            }
        }
    }
}