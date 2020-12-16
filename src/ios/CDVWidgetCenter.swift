import Foundation
#if canImport(WidgetKit)
import WidgetKit
#endif

public class CDVWidgetCenter : CDVPlugin {

  func reloadTimelines(command: CDVInvokedUrlCommand) {
    let kind = command.argument(at: 0) as! String
    var pluginResult:CDVPluginResult
		debugPrint("reloadTimelines ofKind "+kind)
		if #available(iOS 14, *) {
			debugPrint("available")
				WidgetCenter.shared.reloadTimelines(ofKind: kind)
        pluginResult = CDVPluginResult.init(status: CDVCommandStatus_OK, messageAs: "Timeline reloaded")
    } else {
        pluginResult = CDVPluginResult.init(status: CDVCommandStatus_ERROR, messageAs: "This plugin requires iOS 14 +")
    }

    self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
  }

	func reloadAllTimelines(command: CDVInvokedUrlCommand) {
		var pluginResult:CDVPluginResult
		debugPrint("reloadAllTimelines")
		if #available(iOS 14, *) {
					debugPrint("available")
 					WidgetCenter.shared.reloadAllTimelines()
					pluginResult = CDVPluginResult.init(status: CDVCommandStatus_OK, messageAs: "All Timelines reloaded")
			} else {
					pluginResult = CDVPluginResult.init(status: CDVCommandStatus_ERROR, messageAs: "This plugin requires iOS 14 +")
			}
		self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
	}

	func getCurrentConfigurations(command: CDVInvokedUrlCommand) {
		var pluginResult:CDVPluginResult
		debugPrint("getCurrentConfigurations")
		if #available(iOS 14, *) {
					debugPrint("available")
					WidgetCenter.shared.getCurrentConfigurations { result in
				    guard case .success(let widgets) = result else {
							pluginResult = CDVPluginResult.init(status: CDVCommandStatus_ERROR, messageAs: "Unable to retrieve WidgetInfo")
							return
						}
						debugPrint("retrieved widgets")
						pluginResult = CDVPluginResult.init(status: CDVCommandStatus_OK, messageAs: widgets)
					}
			} else {
					pluginResult = CDVPluginResult.init(status: CDVCommandStatus_ERROR, messageAs: "This plugin requires iOS 14 +")
			}
		self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
	}

}
