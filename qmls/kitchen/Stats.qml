import QtQuick 2.6
import QtCharts 2.2

Item {
    property var pieslice
    objectName: "stats"
    FontLoader {
        id: defaultfont;
        source: "../material/fonts/another/Fontfabric-Intro-Book.otf"
    }

    function getColor(index)
    {
        var our = 0
        var total = 0
        for (var i = 0; i < pieslice.count; i++)
        {
            if (pieslice.at(i).value > 0)
                total++
            if (pieslice.at(i).value > 0 && i < index)
                our++
        }
        if (total > 4 && total % 4 == 1 && our == total - 1)
            return "#1d4a5a"
        switch(our % 4)
        {
            case 0: return "#f4b05a"
            case 1: return "#1d4a5a"
            case 2: return "#e94444"
            case 3: return "#57b7a0"
        }
    }

    function generateSlice(index)
    {
        var string = '
                PieSlice {
                    property var name: curencypages[' + index + '].shortName
                    property var bal: curencypages[' + index + '].balance
                    property var curs: curencypages[' + index + '].courses[totalbalancebox.currentText]
                    property var itog: isNaN(bal * curs) ? 0 : bal * curs
                    labelFont.family: defaultfont.name
                    labelFont.pixelSize: 20
                    labelFont.letterSpacing: 2
                    label: name
                    value: itog.toFixed(2)
                    explodeDistanceFactor : 0
                    exploded: true
                    color: getColor(' + index + ')
                    Behavior on explodeDistanceFactor {
                        SmoothedAnimation {
                            velocity: 1
                        }
                    }
                    onHovered:
                    {
                        explodeDistanceFactor = state ? 0.1 : 0
                        label = state ? value : name
                    }
                    labelVisible: value > 0 ? true : false
                }
            '
        return string
    }


    function fillChart()
    {
        var payload = "import QtQuick 2.6;import QtCharts 2.2;PieSeries{"
        for (var i = 0; i < curencypages.length; i++)
            payload += generateSlice(i)
        payload += "}"

        pieslice = Qt.createQmlObject(payload, chart)
    }


    anchors.fill: parent
    Text
    {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Your balance is empty"
        color: "#58b7a1"
        font.family: defaultfont.name
        opacity: 0.87
        font.pixelSize: 30
        font.letterSpacing: 2
        textFormat: Text.PlainText
        visible: {
            var sum = 0
            for (var i = 0; i < curencypages.length; i++)
            {
                var bal = isNaN(curencypages[i].balance) ? 0 : curencypages[i].balance
                sum += bal
            }
            if (sum > 0)
                return false
            else
                return true
        }
    }
    ChartView {
        id: chart
        anchors.fill: parent
        backgroundColor: "transparent"
        legend.visible: false
        antialiasing: true
    }
}