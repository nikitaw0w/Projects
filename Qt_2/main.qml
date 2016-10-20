/**
 * 2 - paint
 *
 * Copyright (c) 2016 Bazhenov Nikita
 */

import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Window 2.2

Window {
    Paint {
        id: paint
        anchors.fill: parent
    }

    property int uper: 10

    property int hgt: Screen.height - 75
    id: item_main
    width: Screen.width - 15
    height: Screen.height - 75
    minimumHeight: paint.tools_count * paint.items_count

    visible: true


}











/*
    Rectangle {
        id: rectik
        x: 300 - uper/2
        y: 300 - uper/2
        width: uper
        height: uper
        //rotation: 120
        radius: uper + 90
        color: "#FAEBD7"
        visible: true
        Rectangle {
            color: "red"
            x: (rectik.x + uper) / 10
            y: (rectik.y + uper) / 10
            width: rectik.width / 10
            height: rectik.height / 10
            radius: rectik.radius / 10
        }
        Rectangle {
            color: "black"
            x: (rectik.x + uper) / 2
            y: (rectik.y + uper) / 2
            width: rectik.width / 10
            height: rectik.height / 10
            radius: rectik.radius / 10
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                 rectik.color = "blue"
                 rectik.visible = false
            }
    }
    }

    Timer {
        triggeredOnStart: true
        running: true
        repeat: true
        interval: 1
        onTriggered: {
            if (uper == 300) uper -= 10
            else uper += 10
        }
    }
*/
