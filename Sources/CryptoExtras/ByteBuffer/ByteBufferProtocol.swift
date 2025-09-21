public protocol ByteBufferProtocol: ~Copyable {
    static var _capacity: Int { get }

    var bytes: RawSpan { get }

    var count: Int { get }

    var freeCapacity: Int { get }

    var isEmpty: Bool { get }

    var isFull: Bool { get }

    init()

    mutating func append(_ byte: UInt8)

    mutating func append(contentsOf input: borrowing RawSpan)

    mutating func pad(with byte: UInt8, toCount newCount: Int)

    mutating func removeAll()
}

extension ByteBufferProtocol where Self: ~Copyable {
    public mutating func pad(with byte: UInt8 = 0, toCount newCount: Int = _capacity) {
        self.pad(with: byte, toCount: newCount)
    }
}
