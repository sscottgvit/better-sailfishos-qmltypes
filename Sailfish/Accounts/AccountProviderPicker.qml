import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Accounts 1.0

Column {
    id: root

    property alias serviceFilter: providerModel.serviceFilter

    signal providerSelected(int index, string providerName)
    signal providerDeselected(int index, string providerName)   // deprecated

    //--- end of public api

    property AccountManager _accountManager: AccountManager {}
    property bool _hasExistingJollaAccount

    function _isCloudStorageProvider(providerName) {
        var provider = _accountManager.provider(providerName)
        if (provider) {
            var serviceNames = provider.serviceNames
            for (var i=0; i<serviceNames.length; i++) {
                var service = _accountManager.service(serviceNames[i])
                if (service && service.serviceType == "storage") {
                    return true
                }
            }
        }
        return false
    }

    function _isOtherProvider(providerName) {
        return providerName.indexOf("email") == 0
            || providerName.indexOf("onlinesync") == 0
    }

    Component.onCompleted: {
        root._hasExistingJollaAccount = (_accountManager.providerAccountIdentifiers("jolla").length > 0)
    }

    Connections {
        target: root._accountManager
        onAccountCreated: {
            if (!root._hasExistingJollaAccount) {
                var account = _accountManager.account(accountId)
                if (account && account.providerName === "jolla") {
                    root._hasExistingJollaAccount = true
                }
            }
        }
    }

    ProviderModel {
        id: providerModel
    }

    Column {
        width: root.width

        Repeater {
            model: providerModel
            delegate: AccountProviderPickerDelegate {
                width: root.width
                // don't offer the chance to create multiple jolla accounts through the UI
                visible: !root._isOtherProvider(model.providerName)
                         && !root._isCloudStorageProvider(model.providerName)
                         && (model.providerName !== "jolla" || !root._hasExistingJollaAccount)
            }
        }
    }

    SectionHeader {
        //: List of account providers that offer cloud storage
        //% "Cloud storage"
        text: qsTrId("components_accounts-la-service_name_cloud_storage")
    }

    Column {
        width: root.width

        Repeater {
            model: providerModel
            delegate: AccountProviderPickerDelegate {
                width: root.width
                visible: root._isCloudStorageProvider(model.providerName)
            }
        }
    }

    SectionHeader {
        //: List of other types of account providers
        //% "Other"
        text: qsTrId("components_accounts-la-other")
    }

    Column {
        width: root.width

        Repeater {
            model: providerModel
            delegate: AccountProviderPickerDelegate {
                width: root.width
                visible: root._isOtherProvider(model.providerName)
            }
        }
    }
}
