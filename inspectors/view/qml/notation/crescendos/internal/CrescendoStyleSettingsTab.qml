import QtQuick 2.9
import QtQuick.Controls 2.2
import MuseScore.Inspectors 3.3
import "../../../common"

FocusableItem {
    id: root

    property QtObject model: null

    implicitHeight: contentColumn.height
    width: parent.width

    Column {
        id: contentColumn

        width: parent.width

        spacing: 12

        CheckBox {
            isIndeterminate: root.model ? root.model.isLineVisible.isUndefined : false
            checked: root.model && !isIndeterminate ? root.model.isLineVisible.value : false
            text: qsTr("Show line")

            onClicked: { root.model.isLineVisible.value = !checked }
        }

        Column {
            width: parent.width

            spacing: 8

            enabled: root.model && root.model.endHookType.isEnabled

            StyledTextLabel {
                text: qsTr("Line type")
            }

            RadioButtonGroup {
                id: lineTypeButtonList

                height: 30
                width: parent.width

                model: [
                    { iconRole: IconNameTypes.LINE_NORMAL, typeRole: CrescendoTypes.HOOK_TYPE_NONE },
                    { iconRole: IconNameTypes.LINE_WITH_END_HOOK, typeRole: CrescendoTypes.HOOK_TYPE_90 },
                    { iconRole: IconNameTypes.LINE_WITH_ANGLED_END_HOOK, typeRole: CrescendoTypes.HOOK_TYPE_45 },
                    { iconRole: IconNameTypes.LINE_WITH_T_LIKE_END_HOOK, typeRole: CrescendoTypes.HOOK_TYPE_T_LIKE },
                ]

                delegate: FlatRadioButton {

                    ButtonGroup.group: lineTypeButtonList.radioButtonGroup

                    checked: root.model && !root.model.endHookType.isUndefined ? root.model.endHookType.value === modelData["typeRole"]
                                                                               : false

                    onToggled: {
                        root.model.endHookType.value = modelData["typeRole"]
                    }

                    StyledIconLabel {
                        iconCode: modelData["iconRole"]
                    }
                }
            }
        }

        SeparatorLine { anchors.margins: -10 }

        Column {
            width: parent.width

            spacing: 8

            enabled: root.model && root.model.lineStyle.isEnabled

            StyledTextLabel {
                text: qsTr("Style")
            }

            RadioButtonGroup {
                id: lineStyleButtonList

                height: 30
                width: parent.width

                model: [
                    { iconRole: IconNameTypes.LINE_NORMAL, typeRole: CrescendoTypes.LINE_STYLE_SOLID },
                    { iconRole: IconNameTypes.LINE_DASHED, typeRole: CrescendoTypes.LINE_STYLE_DASHED },
                    { iconRole: IconNameTypes.LINE_DOTTED, typeRole: CrescendoTypes.LINE_STYLE_DOTTED },
                    { iconRole: IconNameTypes.CUSTOM, typeRole: CrescendoTypes.LINE_STYLE_CUSTOM }
                ]

                delegate: FlatRadioButton {

                    ButtonGroup.group: lineStyleButtonList.radioButtonGroup

                    checked: root.model && !root.model.lineStyle.isUndefined ? root.model.lineStyle.value === modelData["typeRole"]
                                                                             : false

                    onToggled: {
                        root.model.lineStyle.value = modelData["typeRole"]
                    }

                    StyledIconLabel {
                        iconCode: modelData["iconRole"]
                    }
                }
            }
        }

        Item {
            height: childrenRect.height
            width: parent.width

            Column {
                anchors.left: parent.left
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: 2

                spacing: 8

                visible: root.model ? root.model.dashLineLength.isEnabled : false
                height: visible ? implicitHeight : 0

                StyledTextLabel {
                    text: qsTr("Dash")
                }

                IncrementalPropertyControl {
                    iconMode: iconModeEnum.hidden

                    isIndeterminate: root.model ? root.model.dashLineLength.isUndefined : false
                    currentValue: root.model ? root.model.dashLineLength.value : 0
                    step: 0.1
                    maxValue: 10
                    minValue: 0.1
                    decimals: 2

                    onValueEdited: { root.model.dashLineLength.value = newValue }
                }
            }

            Column {
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 2
                anchors.right: parent.right

                spacing: 8

                visible: root.model ? root.model.dashGapLength.isEnabled : false
                height: visible ? implicitHeight : 0

                StyledTextLabel {
                    text: qsTr("Gap")
                }

                IncrementalPropertyControl {
                    iconMode: iconModeEnum.hidden

                    isIndeterminate: root.model && enabled ? root.model.dashGapLength.isUndefined : false
                    currentValue: root.model ? root.model.dashGapLength.value : 0
                    step: 0.1
                    maxValue: 10
                    minValue: 0.1
                    decimals: 2

                    onValueEdited: { root.model.dashGapLength.value = newValue }
                }
            }
        }

        ExpandableBlank {
            isExpanded: false

            title: isExpanded ? qsTr("Show less") : qsTr("Show more")

            width: parent.width

            contentItemComponent: Column {
                height: implicitHeight
                width: root.width

                spacing: 16

                Item {
                    height: childrenRect.height
                    width: parent.width

                    Column {
                        anchors.left: parent.left
                        anchors.right: parent.horizontalCenter
                        anchors.rightMargin: 2

                        spacing: 8

                        enabled: root.model && root.model.thickness.isEnabled

                        StyledTextLabel {
                            text: qsTr("Thickness")
                        }

                        IncrementalPropertyControl {
                            iconMode: iconModeEnum.hidden

                            isIndeterminate: root.model ? root.model.thickness.isUndefined : false
                            currentValue: root.model ? root.model.thickness.value : 0
                            step: 0.1
                            maxValue: 10
                            minValue: 0.1
                            decimals: 2

                            onValueEdited: { root.model.thickness.value = newValue }
                        }
                    }

                    Column {
                        anchors.left: parent.horizontalCenter
                        anchors.leftMargin: 2
                        anchors.right: parent.right

                        spacing: 8

                        enabled: root.model && root.model.hookHeight.isEnabled

                        StyledTextLabel {
                            text: qsTr("Hook height")
                        }

                        IncrementalPropertyControl {

                            iconMode: iconModeEnum.hidden

                            isIndeterminate: root.model ? root.model.hookHeight.isUndefined : false
                            currentValue: root.model ? root.model.hookHeight.value : 0
                            step: 0.1
                            maxValue: 10
                            minValue: 0.1
                            decimals: 2

                            onValueEdited: { root.model.hookHeight.value = newValue }
                        }
                    }
                }

                Column {
                    width: parent.width

                    spacing: 8

                    StyledTextLabel {
                        text: qsTr("Position")
                    }

                    RadioButtonGroup {
                        id: positionButtonList

                        height: 30
                        width: parent.width

                        model: [
                            { textRole: qsTr("Above"), valueRole: CrescendoTypes.PLACEMENT_TYPE_ABOVE },
                            { textRole: qsTr("Below"), valueRole: CrescendoTypes.PLACEMENT_TYPE_BELOW }
                        ]

                        delegate: FlatRadioButton {

                            ButtonGroup.group: positionButtonList.radioButtonGroup

                            checked: root.model && !root.model.placement.isUndefined ? root.model.placement.value === modelData["valueRole"]
                                                                                     : false
                            onToggled: {
                                root.model.placement.value = modelData["valueRole"]
                            }

                            StyledTextLabel {
                                text: modelData["textRole"]

                                elide: Text.ElideRight
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }
                    }
                }
            }
        }
    }
}

