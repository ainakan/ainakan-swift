import Ainakan_Private

public final class ApplicationDetails: CustomStringConvertible, Equatable, Hashable {
    private let handle: OpaquePointer

    init(handle: OpaquePointer) {
        self.handle = handle
    }

    deinit {
        g_object_unref(gpointer(handle))
    }

    public var identifier: String {
        return String(cString: ainakan_application_get_identifier(handle))
    }

    public var name: String {
        return String(cString: ainakan_application_get_name(handle))
    }

    public var pid: UInt? {
        let value = ainakan_application_get_pid(handle)
        return value != 0 ? UInt(value) : nil
    }

    public lazy var parameters: [String: Any] = {
        return Marshal.dictionaryFromParametersDict(ainakan_application_get_parameters(handle))
    }()

    public lazy var icons: [Icon] = {
        guard let iconDicts = parameters["icons"] as? [[String: Any]] else {
            return []
        }
        return iconDicts.map(Marshal.iconFromVarDict)
    }()

    public var description: String {
        if let pid = self.pid {
            return "Ainakan.ApplicationDetails(identifier: \"\(identifier)\", name: \"\(name)\", pid: \(pid), parameters: \(parameters))"
        } else {
            return "Ainakan.ApplicationDetails(identifier: \"\(identifier)\", name: \"\(name)\", parameters: \(parameters))"
        }
    }

    public static func == (lhs: ApplicationDetails, rhs: ApplicationDetails) -> Bool {
        return lhs.handle == rhs.handle
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(UInt(bitPattern: handle))
    }
}
