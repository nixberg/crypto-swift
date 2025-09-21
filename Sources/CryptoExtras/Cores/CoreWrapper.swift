public struct CoreWrapper<Buffer, Core>: ~Copyable
where
    Buffer: ~Copyable & ByteBufferProtocol,
    Core: ~Copyable
{
    var buffer = Buffer()

    var core: Core
}
