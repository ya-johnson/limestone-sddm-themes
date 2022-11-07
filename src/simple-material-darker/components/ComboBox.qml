import QtQuick 2.12
import QtQuick.Controls 2.12

ComboBox {
    id: control

    delegate: ItemDelegate {
        id: itemDelegate
        text: model.realName ? model.realName : model.name
        width: control.width
        contentItem: Text {
            text: itemDelegate.text
            color: config.ForegroundColor
            font: itemDelegate.font
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
        }
        background: Rectangle {
            visible: itemDelegate.down || itemDelegate.highlighted || itemDelegate.visualFocus
            color: config.BackgroundColor
        }
        highlighted: control.highlightedIndex === index
    }

    indicator: Canvas {
        id: canvas
        x: control.width - width - control.rightPadding
        y: control.topPadding + (control.availableHeight - height) / 2
        width: 12
        height: 8
        contextType: "2d"

        Connections {
            target: control
            function onPressedChanged() { canvas.requestPaint(); }
        }

        onPaint: {
            context.reset();
            context.moveTo(0, 0);
            context.lineTo(width, 0);
            context.lineTo(width / 2, height);
            context.closePath();
            context.fillStyle = config.ForegroundColor;
            context.fill();
        }
    }

    contentItem: Text {
        leftPadding: 5
        rightPadding: control.indicator.width + control.spacing

        text: control.displayText
        font: control.font
        color: config.ForegroundColor
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitWidth: 120
        implicitHeight: 30
        border.color: config.BorderColor
        border.width: 1
        color: control.pressed ? config.BackgroundColor : config.SecondBackgroundColor
        radius: 3
    }

    popup: Popup {
        y: control.height - 1
        width: control.width
        implicitHeight: contentItem.implicitHeight
        padding: 2

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: control.popup.visible ? control.delegateModel : null
            currentIndex: control.highlightedIndex
            ScrollIndicator.vertical: ScrollIndicator { }
        }

        background: Rectangle {
            border.color: config.BorderColor
            color: config.BackgroundColor
        }
    }

    function getValue() {
        return control.delegateModel.items.get(control.currentIndex).model.name;
    }
}
