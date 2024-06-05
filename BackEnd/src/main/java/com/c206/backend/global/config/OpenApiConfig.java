package com.c206.backend.global.config;

import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.security.SecurityRequirement;
import io.swagger.v3.oas.models.security.SecurityScheme;
import org.springframework.context.annotation.Bean;

public class OpenApiConfig {

    @Bean
    public OpenAPI openAPI(){

        Info info = new Info()
                .version("v1.0.0")
                .title("GingGing API")
                .description("API Description");

        //SecurityScheme 이름
        String jwtSchemeName = "jwtAuth";
        //API 요청 헤더에 인증정보 포함하기
        SecurityRequirement securityRequirement = new SecurityRequirement().addList(jwtSchemeName);
        //SecuritySchemes 등록
        Components components = new Components()
                .addSecuritySchemes(jwtSchemeName, new SecurityScheme()
                        .name(jwtSchemeName)
                        .type(SecurityScheme.Type.HTTP)
                        .scheme("bearer")
                        .bearerFormat("JWT"));

        return new OpenAPI()
                .info(info)
                .addSecurityItem(securityRequirement)
                .components(components);
    }
}
