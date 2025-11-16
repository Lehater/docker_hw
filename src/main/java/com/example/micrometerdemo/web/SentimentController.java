package com.example.micrometerdemo.web;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/api")
public class SentimentController {

    @GetMapping("/sentiment")
    public Map<String, String> analyzeSentiment(@RequestParam("text") String text) {
        String normalized = text.toLowerCase();

        String sentiment;
        if (normalized.contains("bad") || normalized.contains("hate")) {
            sentiment = "negative";
        } else if (normalized.contains("great") || normalized.contains("love") || normalized.contains("good")) {
            sentiment = "positive";
        } else {
            sentiment = "neutral";
        }

        return Map.of("sentiment", sentiment);
    }
}
