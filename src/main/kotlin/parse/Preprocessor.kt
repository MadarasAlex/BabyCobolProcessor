package parse

import org.antlr.v4.runtime.CharStream
import org.antlr.v4.runtime.CharStreams
import parse.CompileException.Companion.addError
import java.io.File

/**
 * Reads a file, preprocesses it and returns a CharStream from it.
 */
fun readFile(fileName: String): CharStream {
    val file = File(fileName)
    val rawCode = file.readText()
    return preprocess(rawCode)
}

/**
 * Any preprocessing to be done on the code.
 */
fun preprocess(code: String): CharStream {
    val errors = emptyList<String>().toMutableList()

    // Feature L2.1: positional parsing
    // Split into lines, ignore 73rd column and beyond. Pad lines with 6 spaces and a * if it only contains whitespace
    val lines = code.lines().map{ it.take(72).let { it.ifBlank { "      *" } } }
    val result = buildList<String> {
        for (i in lines.indices) {
            when (lines[i][6]) {
                ' ' -> add(lines[i].drop(7)) // Code, add new line
                '*' -> add("") // Comment, add empty line instead
                '-' -> {  // Continuation
                    this[i-1] = this[i-1] + '¬' // Add a marker to the last line so ANTLR can ignore a possible indent
                    add(lines[i].drop(7)) // And add the new one
                }
                else -> errors.addError(i + 1, 7, "Illegal character '${lines[i][6]}', must be ' ', '*' or '-'")
            }
        }
    }.joinToString("\n") { "      " + it.let { if (it.isNotEmpty() && it.take(4) != "    ") "~$it" else " $it" } } // Reassemble the lines afterwards

    // If preprocessing has errors, throw an exception. Else, return the result to be parsed.
    if (errors.isNotEmpty()) throw CompileException(errors)
    return CharStreams.fromString(result)
}

