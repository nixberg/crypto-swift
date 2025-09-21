extension UInt8 {
    init(parsing input: inout RawSpan) {
        self = unsafe input.unsafeLoad(as: Self.self)
        input = input.extracting(1...)
    }
}
