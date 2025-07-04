@freestanding(expression)
macro myMacro() -> String = #externalMacro(module: "MyMacros", type: "MyMacro")

let value = #myMacro
