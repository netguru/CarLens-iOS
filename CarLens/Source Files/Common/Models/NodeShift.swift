//
//  NodeShift.swift
//  CarLens
//


internal struct NodeShift: Equatable {

    let depth: Float
    let elevation: Float

    /// SeeAlso: Equatable
    static func == (lhs: NodeShift, rhs: NodeShift) -> Bool {
        return lhs.depth == rhs.depth && lhs.elevation == rhs.elevation
    }
}
