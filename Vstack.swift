VStack {
    List(students) { student in
        Text(student.name ?? "Unknown")
    }
}
