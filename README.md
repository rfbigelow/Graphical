# Graphical

A library for processing and visualizing mathematical graph objects.

## About

Graphical is a personal project which I'm using to explore graph algorithms, Swift programming, and library development.

## Design Notes

- Protocol-based: I'm striving to represent graphs in a way that can be applied to any domain. The current design uses an approach that I learned from Sedgewick and Wayne in Algorithms, 4 ed. This approach represents vertices as integers, with edges implicitly defined by adjacency lists.
- Array-based: The initial implementation will utilize Swift arrays in the API. After I experiment with the results of this implementation it is my intent to revisit this design to improve efficiency where it makes sense.
- Integer sizes: Another idea that I've set aside to begin with is allowing the vertex type to be any FixedWidthInteger type in order to contol the memory footprint. There's an inherent tension here though, as larger integer types are needed to support more vertices.
