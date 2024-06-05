package com.c206.backend.global.config;


import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.reactive.function.client.WebClient;

@Configuration
public class WebClientConfig {

    @Value("${flask.server-url}")
    private String flaskUrl;

    @Bean
    public WebClient webClient() {
        return WebClient.create(flaskUrl); // 플라스크 서버 URL
    }
}