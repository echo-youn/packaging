package com.echoyoun.dockerpackaging

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
class DockerPackagingApplication

fun main(args: Array<String>) {
    runApplication<DockerPackagingApplication>(*args)
}
