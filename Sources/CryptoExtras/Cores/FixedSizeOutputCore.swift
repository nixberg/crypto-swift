public protocol FixedSizeOutputCore: ~Copyable {
    static var outputByteCount: Int { get }

    mutating func finalize<Buffer>(
        withBuffer buffer: inout Buffer,
        into output: inout MutableRawSpan
    ) where Buffer: ~Copyable & ByteBufferProtocol
}

extension CoreWrapper where Buffer: ~Copyable, Core: ~Copyable & FixedSizeOutputCore {
    public consuming func finalize(into output: inout MutableRawSpan) {
        var core = consume core
        var buffer = consume buffer
        core.finalize(withBuffer: &buffer, into: &output)
    }

    public consuming func finalized() -> [UInt8] {
        var core = consume core
        var buffer = consume buffer
        var result = [UInt8](repeating: 0, count: Core.outputByteCount)
        var mutableSpan = result.mutableSpan
        var mutableBytes = mutableSpan.mutableBytes
        core.finalize(withBuffer: &buffer, into: &mutableBytes)
        return result
    }
}

extension CoreWrapper
where
    Buffer: ~Copyable,
    Core: ~Copyable & FixedSizeOutputCore & InitCore & UpdateCore
{
    public static func hash(_ bytes: borrowing RawSpan) -> [UInt8] {
        var digest = Self()
        digest.update(with: bytes)
        return digest.finalized()
    }
}
