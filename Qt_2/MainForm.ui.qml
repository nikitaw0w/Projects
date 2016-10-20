import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Window 2.2

Rectangle {
    property alias mouseArea: mouseArea
    visible: false
    width: 360
    height: 360

    MouseArea {
        id: mouseArea
        anchors.rightMargin: -8
        anchors.bottomMargin: -18
        anchors.leftMargin: 8
        anchors.topMargin: 18
        anchors.fill: parent

        MouseArea {
            id: mouseArea1
            x: 8
            y: 33
            width: 100
            height: 100
        }

        Button {
            id: button1
            x: 143
            y: 59
            width: 159
            height: 23
            text: qsTr("Button")
        }

        Slider {
            id: sliderHorizontal1
            x: 85
            y: 169
            width: 239
            height: 22
        }
    }
}

