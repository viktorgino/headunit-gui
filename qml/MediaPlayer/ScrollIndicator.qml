import QtQuick 2.0

Rectangle {
    id: container
    width: 300
    height: 360

    ListModel {
        id: animalsModel
        ListElement { name: "Ant"; size: "Tiny" }
        ListElement { name: "Flea"; size: "Tiny" }
        ListElement { name: "Parrot"; size: "Small" }
        ListElement { name: "Guinea pig"; size: "Small" }
        ListElement { name: "Rat"; size: "Small" }
        ListElement { name: "Butterfly"; size: "Small" }
        ListElement { name: "Dog"; size: "Medium" }
        ListElement { name: "Cat"; size: "Medium" }
        ListElement { name: "Pony"; size: "Medium" }
        ListElement { name: "Koala"; size: "Medium" }
        ListElement { name: "Horse"; size: "Large" }
        ListElement { name: "Tiger"; size: "Large" }
        ListElement { name: "Giraffe"; size: "Large" }
        ListElement { name: "Elephant"; size: "Huge" }
        ListElement { name: "Whale"; size: "Huge" }
    }

    // The delegate for each section header
    Component {
        id: sectionHeading
        Rectangle {
            width: container.width
            height: childrenRect.height
            color: "lightsteelblue"

            Text {
                text: section
                font.bold: true
                font.pixelSize: 20
            }
        }
    }

    ListView {
        id: view
        anchors.top: parent.top
        anchors.bottom: buttonBar.top
        width: parent.width
        model: animalsModel
        delegate: Text { text: name; font.pixelSize: 18 }

        section.property: "size"
        section.criteria: ViewSection.FullString
        section.delegate: sectionHeading
    }

    Row {
        id: buttonBar
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 1
        spacing: 1
        ToggleButton {
            label: "CurrentLabelAtStart"
            onToggled: {
                if (active)
                    view.section.labelPositioning |= ViewSection.CurrentLabelAtStart
                else
                    view.section.labelPositioning &= ~ViewSection.CurrentLabelAtStart
            }
        }
        ToggleButton {
            label: "NextLabelAtEnd"
            onToggled: {
                if (active)
                    view.section.labelPositioning |= ViewSection.NextLabelAtEnd
                else
                    view.section.labelPositioning &= ~ViewSection.NextLabelAtEnd
            }
        }
    }
}
