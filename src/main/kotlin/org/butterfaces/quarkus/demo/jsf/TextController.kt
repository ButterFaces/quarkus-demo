package org.butterfaces.quarkus.demo.jsf

import java.io.Serializable
import javax.faces.view.ViewScoped
import javax.inject.Named

@Named
@ViewScoped
class TextController(var name: String = "") : Serializable {

    var hello: String = ""
        private set

    fun sayHello() {
        hello = """
            Hello $name,
            welcome to JSF
        """.trimIndent()
    }

}