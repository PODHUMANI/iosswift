 Picker("", selection: $selectedDept) {
                    ForEach(departments, id: \.self) { dept in
                        Text(dept)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                }
                .pickerStyle(.menu) // or .navigationLink, .inline
                .frame(maxWidth: .infinity, alignment: .leading)
