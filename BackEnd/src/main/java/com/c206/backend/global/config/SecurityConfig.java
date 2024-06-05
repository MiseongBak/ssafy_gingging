package com.c206.backend.global.config;

import com.c206.backend.domain.member.service.RedisService;
import com.c206.backend.global.jwt.CustomUserDetailsService;
import com.c206.backend.global.jwt.LoginFilter;
import com.c206.backend.global.jwt.JwtTokenFilter;
import com.c206.backend.global.jwt.JwtTokenUtil;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
    // 다른 필요한 메소드들 추가 가능

    private final AuthenticationConfiguration authenticationConfiguration;

    private final JwtTokenUtil jwtTokenUtil;

    private final CustomUserDetailsService customUserDetailsService;


    private final RedisService redisService;

    public SecurityConfig(AuthenticationConfiguration authenticationConfiguration, JwtTokenUtil jwtTokenUtil, CustomUserDetailsService customUserDetailsService, RedisService redisService) {

        this.authenticationConfiguration = authenticationConfiguration;
        this.jwtTokenUtil = jwtTokenUtil;
        this.customUserDetailsService = customUserDetailsService;
        this.redisService = redisService;
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration configuration) throws Exception {

        return configuration.getAuthenticationManager();
    }

    @Bean
    public BCryptPasswordEncoder bCryptPasswordEncoder(){
        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

        http
                .csrf((auth) -> auth.disable());

        http
                .formLogin((auth) -> auth.disable());

        http
                .httpBasic((auth) -> auth.disable());

        http
                .authorizeHttpRequests((auth)->auth
                        .requestMatchers("/", "/**", "/api/v1/member/signin",
                                "/api/v1", "/api/v1/", "/api/v1/**",
                                "/v3/api-docs/**", "/swagger-ui/**", "/swagger-ui.html", "/webjars/**").permitAll()
                        .anyRequest().authenticated());

        //JWTFilter 등록
        http
                .addFilterBefore(new JwtTokenFilter(jwtTokenUtil), LoginFilter.class);

        http
                .addFilterAt(new LoginFilter(authenticationManager(authenticationConfiguration), jwtTokenUtil,customUserDetailsService, redisService), UsernamePasswordAuthenticationFilter.class);

        http
                .sessionManagement((session) -> session
                        .sessionCreationPolicy(SessionCreationPolicy.STATELESS));

        return http.build();
    }
}
