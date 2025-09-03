struct Hexagon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let width  = rect.width
        let height = rect.height
        let segments = HexagonParameters.segments

        path.move(to: CGPoint(x: width * 0.5, y: height * 0.0))

        for segment in segments {
            path.addLine(to: CGPoint(x: width * segment.line.x,
                                     y: height * segment.line.y))
            path.addQuadCurve(to: CGPoint(x: width * segment.curve.x,
                                          y: height * segment.curve.y),
                              control: CGPoint(x: width * segment.control.x,
                                               y: height * segment.control.y))
        }

        path.closeSubpath()

        return path
    }
}
