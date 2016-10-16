/**
 * 1 - temp_converter
 *
 * Copyright (c) 2016 Bazhenov Nikita
 */

import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtMultimedia 5.2
import QtQuick.Layouts 1.1

ApplicationWindow {
    id: window
    title: qsTr("Преобразователь температур")
    width: minimumWidth
    height: minimumHeight
    visible: true

    minimumWidth: col1.implicitWidth + col1.anchors.leftMargin + col1.anchors.rightMargin
    minimumHeight: col1.implicitHeight + col1.anchors.topMargin + col1.anchors.bottomMargin

    property real x: 0
    property var l: Qt.locale()

    ColumnLayout {
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        id: col1
        spacing: 10
        anchors.left: parent.left
        anchors.top: parent.top

        /*Grid {
            columns: 1
            rows: 1
            TextField {
                //validator: DoubleValidator{}
                id: field
                focus: true
            }
        }
*/
        TextField {
            id: field
            focus: true
        }

        Grid {
            horizontalItemAlignment: Qt.AlignRight
            columnSpacing: 15
            columns: 2
            rows: 6
            spacing: 20

            Text {
                Layout.alignment: Qt.AlignRight
                text: "Fahrenheit" + " " + field.text
            }

            Text { //1
                Layout.alignment: Qt.AlignRight
                text: try {
                          //(((Number.fromLocaleString(l, field.text)) - 32) * 5/9).toLocaleString(l)
                          "Celsius" + " " + (((Number.fromLocaleString(l, field.text)) - 32) * 5/9).toLocaleString(l)
                      } catch (l) {
                        "ERROR";
                      }
            }

            Text {
                Layout.alignment: Qt.AlignRight
                text: "Fahrenheit" + " " + field.text
            }

            Text { //2
                Layout.alignment: Qt.AlignRight
                text: try {
                          (((Number.fromLocaleString(l, field.text)) - 32) * 5/9 + 273.15).toLocaleString(l)
                          "Kelvin" + " " + (((Number.fromLocaleString(l, field.text)) - 32) * 5/9 + 273.15).toLocaleString(l)
                      } catch (l) {
                        "ERROR";
                      }
            }

            Text {
                Layout.alignment: Qt.AlignLeft
                text: "Celsius" + " " + field.text
            }

            Text { //3
                Layout.alignment: Qt.AlignRight
                text: try {
                          ((Number.fromLocaleString(l, field.text)) * 9/5 + 32).toLocaleString(l)
                          "Fahrenheit" + " " + ((Number.fromLocaleString(l, field.text)) * 9/5 + 32).toLocaleString(l)
                      } catch (l) {
                        "ERROR";
                      }
            }

            Text {
                Layout.alignment: Qt.AlignRight
                text: "Celsius" + " " + field.text
            }

            Text { //4
                Layout.alignment: Qt.AlignRight
                text: try {
                          "Kelvin" + " " + ((Number.fromLocaleString(l, field.text)) + 273.15).toLocaleString(l)
                      } catch (l) {
                        "ERROR";
                      }
            }

            Text {
                Layout.alignment: Qt.AlignRight
                text: "Kelvin" + " " + field.text
            }

            Text { //5
                Layout.alignment: Qt.AlignRight
                text: try {
                          "Fahrenheit" + " " + (((Number.fromLocaleString(l, field.text)) - 273.15) * 9/5 + 32).toLocaleString(l)
                      } catch (l) {
                        "ERROR"
                      }
            }

            Text {
                Layout.alignment: Qt.AlignRight
                text: "Kelvin" + " " + field.text
            }

            Text { //6
                Layout.alignment: Qt.AlignRight
                text: try {
                          "Celsius" + " " + ((Number.fromLocaleString(l, field.text)) - 273.15).toLocaleString(l)
                      } catch (l) {
                        "ERROR";
                      }
            }
        }
    }

   /* GridLayout {
        id: grid
        columns: 3

        Text { text: "Three"; font.bold: true; }
        Text { text: "words"; color: "red" }
        Text { text: "in"; font.underline: true }
        Text { text: "a"; font.pixelSize: 20 }
        Text { text: "row"; font.strikeout: true }
    } */
}

//property int switcher: 1
//property real exp: 0
//property int ind: 50

/*property real t1: 0
property real t2: 0
property real t3: 0
property real t4: 0
property real t5: 0
property real t6: 0
*/

/*function transform()
{
    x = field.text*1;

    t3 = (x * 9/5 + 32).toFixed(2)
    t5 = ((x - 273.15) * 9/5 + 32).toFixed(2)
    t1 = ((x - 32) * 5/9).toFixed(2)
    t6 = (x - 273.15).toFixed(2)
    t2 = ((x - 32) * 5/9 + 273.15).toFixed(2)
    t4 = (x + 273.15).toFixed(2)

    //xy = Number.fromLocaleString(german, "123,456")
}
*/
