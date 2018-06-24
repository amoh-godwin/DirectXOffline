import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

ApplicationWindow {
    visible: true
    id: window
    width: 512
    height: 512


    property bool agreeBtnChecked: false

    property bool backBtnChecked: false
    property int progressPercent: 75
    property QtObject func: install
    property string installing_text: "Initialising"

    property string completed_text: "Finished"
    property bool held: false
    property int prevX: 0
    property int prevY: 0

    header: Rectangle {
        width: parent.width
        height: 32
        color: "dodgerblue"

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onPressAndHold: {
                held = true
            }

            onReleased: {
                held = false
            }

            onMouseXChanged:  {
                console.log(mouse.x)
            }

            onPositionChanged: {

                if(held) {

                    /*var curr_x = mouseX - prevX
                    var curr_y = mouseY - prevY
                    var r_curr_x = prevX - mouseX
                    var r_curr_y = prevY - mouseY
                    if(curr_x < 0) {
                        window.x += r_curr_x
                        window.y += r_curr_y
                    } else {
                        window.x += (curr_x)
                        window.y += (curr_y)
                    }


                    console.log(curr_x, curr_y)
                    //console.log(mouse.x, mouse.y)
                    prevX = mouseX
                    prevY = mouseY*/

                    //window.x = mouseX
                    //console.log(mouse.x)

                }
            }

        }

    }

    StackView {
        id: stack
        width: parent.width
        height: parent.height
        initialItem: init

        Component {
            id: init

            RowLayout {
                height: window.height - 72
                spacing: 12

                Rectangle {
                    width: window.width / 3
                    Layout.fillHeight: true
                    color: "blue"
                }

                Rectangle {
                    id: col_cont
                    width: window.width / 3 * 2
                    Layout.fillHeight: true
                    color: "white"

                    ColumnLayout {
                        anchors.right: parent.right
                        anchors.rightMargin: 12
                        width: parent.width
                        height: parent.height
                        spacing: 0

                        Text {
                            padding: 12
                            text: qsTr('Welcome to Setup for DirectX')
                            font.pixelSize: 20
                            //font.bold: true
                        }

                        Text {
                            padding: 12
                            Layout.fillWidth: true
                            wrapMode: Text.WordWrap
                            text: qsTr('The DirectX setup wizard guides you consectetur adipiscing elit.' +
                                       'Morbi placerat, erat ut eleifend fermentum, purus diam pharetra mi,' +
                                       'quis fringilla lectus ipsum sit amet arcu.' +
                                       ' dapibus ultricies libero. Vivamus imperdiet placerat arcu a tempor.')
                            font.family: "Segoe UI"
                            font.pixelSize: 12
                            color: Qt.rgba(0, 0, 0, 0.8)
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            //height: 400
                            ScrollView {
                                width: parent.width
                                height: parent.height
                                clip: true
                                TextArea {
                                    wrapMode: TextEdit.Wrap
                                    text: qsTr("")
                                }
                            }
                        }

                        RadioButton {
                            id: radioBtn
                            text: qsTr('I accept the agreement')

                            onToggled: {
                                if(checked) {

                                    agreeBtnChecked = true
                                }
                            }

                        }

                        RadioButton {
                            text: qsTr('I don\'t accept the agreement')

                            onToggled: {
                                if(checked) {

                                    agreeBtnChecked = false
                                }
                            }

                        }

                    }

                }

            }

        }

        Component {
            id: install

            ColumnLayout {
                width: stack.width
                height: stack.height
                spacing: 0

                Rectangle {
                    Layout.fillWidth: true
                    height: stack.height / 5

                    Column {
                        padding: 24
                        Text {
                            text: qsTr('DirectX Setup')
                            font.family: "Segoe UI"
                            font.pixelSize: 12
                            font.bold: true
                        }

                        Text {
                            padding: 12
                            font.family: "Segoe UI"
                            text: qsTr('Install DirectX runtime components')
                        }

                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    height: stack. height / 5 * 4
                    color: "#45777777"

                    ColumnLayout {
                        width: parent.width
                        anchors {
                            left: parent.left
                            leftMargin: 36
                            top: parent.top
                            topMargin: 12
                            right: parent.right
                            rightMargin: 36
                        }

                        Text {
                            text: qsTr('Installing Components:')
                            font.family: "Segoe UI"
                            font.pixelSize: 12
                            font.bold: true
                        }

                        Text {
                            Layout.fillWidth: true
                            leftPadding: 36
                            bottomPadding: 36
                            elide: Text.ElideMiddle
                            font.family: "Segoe UI"
                            text: qsTr(installing_text)
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            height: 8
                            color: "transparent"
                            border.color: "#75777777"

                            Rectangle {
                                width: parent.width / 100 * progressPercent
                                height: 8
                                color: "dodgerblue"
                            }

                        }

                    }

                }

            }

        }

        Component {
            id: finish

            RowLayout {
                height: window.height - 88
                spacing: 12

                Rectangle {
                    width: window.width / 3
                    Layout.fillHeight: true
                    color: "blue"
                }

                Rectangle {
                    id: col_cont
                    width: window.width / 3 * 2
                    Layout.fillHeight: true
                    color: "white"

                    ColumnLayout {
                        anchors.right: parent.right
                        anchors.rightMargin: 12
                        width: parent.width
                        //height: parent.height
                        spacing: 0

                        Text {
                            padding: 12
                            text: qsTr('Installation End')
                            font.pixelSize: 20
                            //font.bold: true
                        }

                        Text {
                            padding: 12
                            text: qsTr(completed_text)
                            font.family: "Segoe UI"
                            font.pixelSize: 12
                        }

                    }

                }

            }

        }

    }

    footer: ToolBar {


        RowLayout {
            anchors.right: parent.right
            height: parent.height
            spacing: 0

            Button {
                text: qsTr('Back')
                enabled: backBtnChecked
            }

            Button {
                text: qsTr('Next')
                enabled: agreeBtnChecked
                onClicked: {
                    agreeBtnChecked = false
                    DirectInstaller.start()
                    stack.push(func)
                }
            }

            Button {
                text: qsTr('Cancel')
            }

        }

    }

    Connections {
        target: DirectInstaller

        onProgressChanged: {
            progressPercent = progress
        }

        onCurrentStatusChanged: {
            installing_text = status
        }

        onCompleted: {
            completed_text = _install
            stack.push(finish)
        }
    }

}
