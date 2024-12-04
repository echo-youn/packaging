package com.echoyoun.dockerpackaging

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.RestController

@RestController("/hello")
class MyController {
    @GetMapping(value = ["/world"])
    fun world(
        @RequestParam message: String,
    ): String {
        return message
    }
}
