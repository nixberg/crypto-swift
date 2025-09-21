public struct InlineByteBuffer<let capacity: Int>: ~Copyable, ByteBufferProtocol {
    public static var _capacity: Int {
        capacity
    }

    private var storage: InlineArray<capacity, UInt8>

    private var endIndex = 0

    public var bytes: RawSpan {
        storage.span.bytes.extracting(..<endIndex)
    }

    public var count: Int {
        endIndex
    }

    public var freeCapacity: Int {
        capacity - count
    }

    public var isEmpty: Bool {
        startIndex == endIndex
    }

    public var isFull: Bool {
        count == capacity
    }

    private var startIndex: Int {
        0
    }

    public init() {
        precondition(capacity >= 0, "TODO")
        storage = InlineArray(repeating: 0)
    }

    public mutating func append(_ byte: UInt8) {
        precondition(freeCapacity >= 1, "TODO")
        storage[endIndex] = byte
        endIndex += 1
    }

    public mutating func append(contentsOf input: borrowing RawSpan) {
        precondition(freeCapacity >= input.byteCount, "TODO")
        var input = copy input
        while !input.isEmpty {
            storage[endIndex] = UInt8(parsing: &input)
            endIndex += 1
        }
    }

    public mutating func pad(with byte: UInt8, toCount newCount: Int) {
        precondition(count <= newCount, "TODO")
        precondition(newCount <= capacity, "TODO")
        let endIndex = endIndex  // Overlapping access workaround.
        var mutableSpan = storage.mutableSpan
        var mutableSubSpan = mutableSpan._mutatingExtracting(endIndex..<newCount)
        mutableSubSpan.update(repeating: byte)
        self.endIndex = newCount
        assert(count == newCount)
    }

    public mutating func removeAll() {
        endIndex = 0
    }
}
