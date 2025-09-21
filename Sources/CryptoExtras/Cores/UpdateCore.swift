public protocol UpdateCore: ~Copyable {
    static var blockByteCount: Int { get }

    mutating func update(withBlock block: borrowing RawSpan)
}

extension CoreWrapper where Buffer: ~Copyable, Core: ~Copyable & UpdateCore {
    public mutating func update(with input: borrowing RawSpan) {
        var input = input.extracting(...)

        if !input.isEmpty {
            buffer.append(contentsOf: input.extract(first: buffer.freeCapacity))
            guard buffer.isFull else {
                return
            }
            core.update(withBlock: buffer.bytes)
            buffer.removeAll()
        }

        while input.byteCount >= Core.blockByteCount {
            core.update(withBlock: input.extract(Core.blockByteCount...))
        }

        buffer.append(contentsOf: input)
    }
}

extension RawSpan {
    @_lifetime(copy self)
    fileprivate mutating func extract(first count: Int) -> Self {
        let prefix = self.extracting(first: count)
        self = self.extracting(prefix.byteCount...)
        return prefix
    }

    @_lifetime(copy self)
    fileprivate mutating func extract(_ bounds: some RangeExpression<Int>) -> Self {
        let prefix = self.extracting(bounds)
        self = self.extracting(prefix.byteCount...)
        return prefix
    }
}
