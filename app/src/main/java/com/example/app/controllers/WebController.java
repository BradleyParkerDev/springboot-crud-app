package com.example.app.controllers;

import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

// @RestController
// public class WebController {

//     @GetMapping("/")
//     public Map<String, String> index() {
//         return Map.of("message", "Hello, Bradley!");
//     }
// }

@RestController
public class WebController {

    @GetMapping(value = "/", produces = "application/json")
    public Map<String, String> index() {
        return Map.of("message", "Hello, Bradley!");
    }
}
