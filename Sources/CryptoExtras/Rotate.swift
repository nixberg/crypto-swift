extension FixedWidthInteger where Self: UnsignedInteger {
    public mutating func rotate(left count: Int) {
        self = self.rotated(left: count)
    }

    public mutating func rotate(right count: Int) {
        self = self.rotated(right: count)
    }

    public func rotated(left count: Int) -> Self {
        self &<< count | self &>> (Self.bitWidth - count)
    }

    public func rotated(right count: Int) -> Self {
        self &<< (Self.bitWidth - count) | self &>> count
    }
}
