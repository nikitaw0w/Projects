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
        spacing: 20
        anchors.left: parent.left
        anchors.top: parent.top


        TextField {
            id: field
            focus: true
            width: window.minimumWidth
            height: window.minimumHeight
        }

        Grid {
            horizontalItemAlignment: Qt.AlignRight
            columnSpacing: 15
            columns: 2
            rows: 6
            spacing: 20

            Text {
                Layout.alignment: Qt.AlignRight
                text: field.text + " F"//"Fahrenheit" + " " + field.text
            }

            Text { //1
                Layout.alignment: Qt.AlignRight
                text: try {
                          (((Number.fromLocaleString(l, field.text)) - 32) * 5/9).toLocaleString(l) + "C"
                      } catch (l) {
                        "ERROR";
                      }
            }

            Text {
                Layout.alignment: Qt.AlignRight
                text: field.text + " F"//"Fahrenheit" + " " + field.text
            }

            Text { //2
                Layout.alignment: Qt.AlignRight
                text: try {
                          //(((Number.fromLocaleString(l, field.text)) - 32) * 5/9 + 273.15).toLocaleString(l)
                          (((Number.fromLocaleString(l, field.text)) - 32) * 5/9 + 273.15).toLocaleString(l) + "K"
                      } catch (l) {
                        "ERROR";
                      }
            }

            Text {
                Layout.alignment: Qt.AlignLeft
                text: field.text + " C"//"Celsius" + " " + field.text
            }

            Text { //3
                Layout.alignment: Qt.AlignRight
                text: try {
                          //((Number.fromLocaleString(l, field.text)) * 9/5 + 32).toLocaleString(l)
                          ((Number.fromLocaleString(l, field.text)) * 9/5 + 32).toLocaleString(l) + "F"
                      } catch (l) {
                        "ERROR";
                      }
            }

            Text {
                Layout.alignment: Qt.AlignRight
                text: field.text + "C"//"Celsius" + " " + field.text
            }

            Text { //4
                Layout.alignment: Qt.AlignRight
                text: try {
                          ((Number.fromLocaleString(l, field.text)) + 273.15).toLocaleString(l) + "K"
                      } catch (l) {
                        "ERROR";
                      }
            }

            Text {
                Layout.alignment: Qt.AlignRight
                text: field.text + "K"//"Kelvin" + " " + field.text
            }

            Text { //5
                Layout.alignment: Qt.AlignRight
                text: try {
                          (((Number.fromLocaleString(l, field.text)) - 273.15) * 9/5 + 32).toLocaleString(l) + "F"
                      } catch (l) {
                        "ERROR"
                      }
            }

            Text {
                Layout.alignment: Qt.AlignRight
                text: field.text + "K"//"Kelvin" + " " + field.text
            }

            Text { //6
                Layout.alignment: Qt.AlignRight
                text: try {
                          ((Number.fromLocaleString(l, field.text)) - 273.15).toLocaleString(l) + "C"
                      } catch (l) {
                        "ERROR";
                      }
            }
        }
    }

}
