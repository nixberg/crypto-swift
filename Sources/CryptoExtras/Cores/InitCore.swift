public protocol InitCore: ~Copyable {
    init()
}

extension CoreWrapper where Buffer: ~Copyable, Core: ~Copyable & InitCore {
    public init() {
        core = Core()
    }
}
