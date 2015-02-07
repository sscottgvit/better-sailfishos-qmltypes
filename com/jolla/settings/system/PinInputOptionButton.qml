import QtQuick 2.0
import Sailfish.Silica 1.0

BackgroundItem {
    id: root

    property string text
    property bool emergency
    property bool showWhiteBackgroundByDefault

    visible: text !== ""
    highlighted: showWhiteBackgroundByDefault || down

    highlightedColor: {
        if (emergency) {
            return "white"
        }
        return Theme.rgba(Theme.highlightBackgroundColor, Theme.highlightBackgroundOpacity)
    }

    Rectangle {
        anchors.fill: parent
        anchors.margins: 2
        color: "#4c0000"
        radius: 4
        visible: root.showWhiteBackgroundByDefault && root.down
    }

    Label {
        anchors.centerIn: parent
        text: root.text
        font.pixelSize: Theme.fontSizeMedium
        font.bold: root.emergency

        color: {
            if (root.emergency) {
                if (showWhiteBackgroundByDefault) {
                    return root.down ? "white" : "black"
                }
                return root.highlighted ? "black" : "white"
            }
            return root.highlighted ? Theme.highlightColor : Theme.primaryColor
        }
    }
}