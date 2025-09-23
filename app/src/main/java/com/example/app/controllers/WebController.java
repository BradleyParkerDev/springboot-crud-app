package com.example.app.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class WebController {

    @GetMapping("/")
    public Map<String, String> index() {
        return Map.of("message", "Hello, Bradley!");
    }
}
