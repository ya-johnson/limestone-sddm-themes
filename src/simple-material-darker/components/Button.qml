import QtQuick 2.12
import QtQuick.Controls 2.12

Button {
    id: control

    contentItem: Text {
        text: control.text
        font: control.font
        color: config.ForegroundColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitWidth: 100
        implicitHeight: 30
        color: control.down ? config.BackgroundColor : config.SecondBackgroundColor
        border.color: config.BorderColor
        border.width: 1
        radius: 3
    }
}
