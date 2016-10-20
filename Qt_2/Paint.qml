/**
 * 2 - paint
 *
 * Copyright (c) 2016 Bazhenov Nikita
 */

import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.2
//import Qt 4.7

Item {
    id: paint
    property int size: 8
    property string color: "black"
    property bool box: true
    property int tool: 1
    property string lastColor1: "#FFE4E1"
    property string lastColor2: "#2E8B57"
    property int tools_count: 30
    property int items_count: 15

    RowLayout {
        id: rowL
        anchors.fill: parent

        ColumnLayout {
            id: colL
            width: 300         
            Layout.preferredWidth: button1.width + 10
            anchors.fill: parent
            anchors.leftMargin: 7
            anchors.topMargin: 7
            anchors.rightMargin: 7
            anchors.top: parent.top
            anchors.left: parent.left
            height: item_main.height / tools_count

            ColorDialog {
                id: colorDialog
                visible: false
                title: "Select color:"
                height: item_main.height / tools_count
                onAccepted: {
                    if (box) {
                        paint.lastColor1 = colorDialog.color
                    } else {
                        paint.lastColor2 = colorDialog.color
                    }
                    paint.color = colorDialog.currentColor
                    box = !box
                }
            }

            Button {
                height: item_main.height / tools_count
                id: button1
                text: "Choose"
                onClicked: {
                colorDialog.visible = true
                }
            }

            Rectangle {
                id: rectangleLastColor1
                width: button1.width
                height: item_main.height / tools_count
                color: {
                    if (paint.lastColor1 != paint.lastColor2) paint.lastColor1
                }
                border.color: "black"
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (paint.lastColor1 != paint.lastColor2) paint.color = paint.lastColor1
                    }
                }
            }

            Rectangle {
                id: rectangleLastColor2
                width: button1.width
                height: item_main.height / tools_count
                color: {
                    if (paint.lastColor1 != paint.lastColor2) paint.lastColor2
                }
                border.color: "black"
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (paint.lastColor1 != paint.lastColor2) paint.color = paint.lastColor2
                    }
                }
            }

            Rectangle {
                id: rectangleColor1
                width: button1.width
                height: item_main.height / tools_count
                color: "red"
                border.color: "black"
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        color = "red"
                    }
                }
            }

            Rectangle {
                id: rectangleColor2
                width: button1.width
                height: item_main.height / tools_count
                color: "yellow"
                border.color: "black"
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        color = "yellow"
                    }
                }
            }

            Rectangle {
                id: rectangleColor3
                width: button1.width
                height: item_main.height / tools_count
                color: "green"
                border.color: "black"
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        color = "green"
                    }
                }
            }

            Rectangle {
                id: rectangleColor4
                width: button1.width
                height: item_main.height / tools_count
                color: "blue"
                border.color: "black"
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        color = "blue"
                    }
                }
            }

            Rectangle {
                id: rectangleColor5
                width: button1.width
                height: item_main.height / tools_count
                color: "cyan"
                border.color: "black"
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        color = "cyan"
                    }
                }
            }

            Rectangle {
                id: rectangleColor6
                width: button1.width
                height: item_main.height / tools_count
                color: "violet"
                border.color: "black"
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        color = "violet"
                    }
                }
            }

            Rectangle {
                id: rectangleColor7
                width: button1.width
                height: item_main.height / tools_count
                color: "black"
                border.color: "black"
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        color = "black"
                    }
                }
            }

            Rectangle {
                id: rectangleColor8
                width: button1.width
                height: item_main.height / tools_count
                color: "white"
                border.color: "black"
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        color = "white"
                    }
                }
            }

            Rectangle {
                Text {
                    id: currentColorText
                    anchors.leftMargin: 10
                    color: {
                        if (paint.color == "black") "white"
                        else "black"
                    }
                    text: " \n   current"
                }
                id: rectangleColorCurrent
                width: button1.width
                height: item_main.height / tools_count
                color: paint.color
                border.color: "black"
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        color = paint.color
                    }
                }
            }

            Slider {
                id: sSlider
                width: button1.width
                height: item_main.height / tools_count
                minimumValue: 3
                maximumValue: 50
                value: 8
                onPressedChanged: {
                    size = value
                }
            }

            Button {
                id: button2
                height: item_main.height / tools_count
                text: "Line"
                onClicked: {
                paint.tool = 1
                }
            }

            Button {
                id: button3
                height: item_main.height / tools_count
                text: "Dot"
                onClicked: {
                paint.tool = 2
                }
            }
        }

        ColumnLayout {

            Rectangle {
                width: parent.width// - colL.width - 10
                height: parent.height
                //anchors.left: colL.right
                border.color: "black"
                //anchors.leftMargin: 5
                //property var ctx
            }

            Canvas {
                id: myCanvas
                anchors.fill: parent

                property var xpos
                property var ypos
                property var ctx

                onPaint: {
                    if (tool == 1)
                    {
                        ctx = myCanvas.getContext('2d')
                        ctx.lineCap = "round"
                        ctx.lineWidth = size
                        ctx.strokeStyle = color
                        ctx.fillStyle = color
                        ctx.beginPath()
                        ctx.moveTo(xpos,ypos)
                        xpos = ma.mouseX
                        ypos = ma.mouseY
                        ctx.lineTo(xpos+0.001,ypos+0.001)
                        ctx.stroke()
                        ctx.fill()
                    }
                    if (tool == 2)
                    {
                        ctx = myCanvas.getContext('2d')
                        ctx.lineCap = "round"
                        ctx.lineWidth = size
                        ctx.strokeStyle = color
                        ctx.fillStyle = color
                        ctx.beginPath()
                        ctx.moveTo(xpos,ypos)
                        xpos = ma.mouseX
                        ypos = ma.mouseY
                        //ctx.lineTo(xpos,ypos)
                        ctx.stroke()
                        ctx.fill()
                        ctx.fillRect(xpos-1, ypos-1, size + 3, size + 3)
                    }

                }

                MouseArea {
                    id: ma
                    anchors.fill: parent
                    onPressed: {
                        myCanvas.xpos = mouseX
                        myCanvas.ypos = mouseY
                        myCanvas.requestPaint()
                    }
                    onPositionChanged: {
                        myCanvas.requestPaint()
                    }
                    }
                }
        }
    }
}
