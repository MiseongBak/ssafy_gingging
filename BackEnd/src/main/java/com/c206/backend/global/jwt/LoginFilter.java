package com.c206.backend.global.jwt;

import com.c206.backend.domain.member.dto.request.SignInRequestDto;
import com.c206.backend.domain.member.dto.response.MemberInfoResponseDto;
import com.c206.backend.domain.member.service.RedisService;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.swagger.v3.oas.annotations.Parameter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import lombok.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.bind.annotation.RequestBody;

import java.io.IOException;
import java.util.Collection;
import java.util.Iterator;

public class LoginFilter extends UsernamePasswordAuthenticationFilter {
    private final AuthenticationManager authenticationManager;

    private final JwtTokenUtil jwtTokenUtil;

    private final CustomUserDetailsService customUserDetailsService;
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    private final RedisService redisService;

    @Value("${spring.jwt.expired-min.access-expiration}")
    private Long AccessTokenExpireTime;
    @Value("${spring.jwt.expired-min.refresh-expiration}")
    private Long RefreshTokenExpireTime;

    static Long accessTokenEXTime;
    static Long refreshTokenEXTime;

    public LoginFilter(AuthenticationManager authenticationManager, JwtTokenUtil jwtTokenUtil, CustomUserDetailsService customUserDetailsService, RedisService redisService) {

        this.authenticationManager = authenticationManager;
        this.jwtTokenUtil = jwtTokenUtil;
        this.customUserDetailsService = customUserDetailsService;
        this.redisService = redisService;

        accessTokenEXTime = AccessTokenExpireTime;
        refreshTokenEXTime = RefreshTokenExpireTime;

        setFilterProcessesUrl("/api/v1/member/signin");
    }

    @Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) throws AuthenticationException {

        System.out.println("여기는 attempAuthentication - LoginFilter");


        SignInRequestDto signInRequestDto = null;
        try {
            signInRequestDto = new ObjectMapper().readValue(request.getReader(), SignInRequestDto.class);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        //클라이언트 요청에서 username, password 추출
//        String email = obtainUsername(request);
//        String password = obtainPassword(request);

        String email = signInRequestDto.getEmail();
        String password = signInRequestDto.getPassword();
        System.out.println("여기의 이메일은 "+ email);
        System.out.println("여기의 패스워드는 "+ password);


//        CustomUserDetails customUserDetails = customUserDetailsService.loadUserByUsername(email);
//        if (customUserDetails != null && bCryptPasswordEncoder.matches(password, customUserDetails.getPassword())) {
//            System.out.println("비밀번호 체크 성공~");
//        }else{
//            System.out.println("비밀번호 체크 실패...");
//            throw new RuntimeException();
//        }

        //스프링 시큐리티에서 username과 password를 검증하기 위해서는 token에 담아야 함
        UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(email, password, null);

        System.out.println(authToken);

        setDetails(request, authToken);

        //token에 담은 검증을 위한 AuthenticationManager로 전달
        return authenticationManager.authenticate(authToken);
    }

    //로그인 성공시 실행하는 메소드 (여기서 JWT를 발급하면 됨)
    @Override
    protected void successfulAuthentication(HttpServletRequest request, HttpServletResponse response, FilterChain chain, Authentication authentication) throws IOException {
        //UserDetailsS
        CustomUserDetails customUserDetails = (CustomUserDetails) authentication.getPrincipal();

        Long memberId = customUserDetails.getId();
        String email = customUserDetails.getEmail();
        String nickname = customUserDetails.getNickname();
        Long memberInfoId = customUserDetails.getProfilePetId();
        int level = customUserDetails.getLevel();
        int currency = customUserDetails.getCurrency();
        String password = customUserDetails.getPassword();
        boolean isTutorial = customUserDetails.isTutorial();

        System.out.println("토큰에서 확인할 수 있는 정보들"+" "+memberId+" "+email+" "+nickname+" "+memberInfoId+" "+level+" "+currency);

        String accessToken = jwtTokenUtil.createAccessJwt(memberId, email, nickname, (long) (14*60*60*1000));
//        String accessToken = jwtTokenUtil.createAccessJwt(memberId, email, nickname, accessTokenEXTime);
        System.out.println("액세스 토큰은 이렇게 생겼다. "+ accessToken);

        String refreshToken = jwtTokenUtil.createRefreshJwt(memberId, email, nickname, (long) (14*60*60*1000));
//        String refreshToken = jwtTokenUtil.createRefreshJwt(memberId, email, nickname, refreshTokenEXTime);
        System.out.println("리프레쉬 토큰은 이렇게 생겼다. "+ refreshToken);

        // 헤더에 Access토큰 부여
        response.addHeader("Authorization", "Bearer " + accessToken);

        // Redis에 Refresh 토큰 저장
        redisService.setValues("refresh "+ email,  refreshToken, (long) (24 * 60 * 60 * 1000));


        // Cookie에 Access, refresh 토큰 부여
        response.addCookie(createCookie("Authorization", accessToken));
        response.addCookie(createCookie("refresh", refreshToken));

        ResponseUserInfoData responseUserInfoData = ResponseUserInfoData.builder()
                .id(memberId)
                .nickname(nickname)
                .profilePetId(memberInfoId)
                .level(level)
                .currency(currency)
                .isTutorial(isTutorial)
                .build();

        ResponseData responseData = ResponseData.builder()
                .jwtAccess(accessToken)
                .jwtRefresh(refreshToken)
                .responseUserInfoData(responseUserInfoData)
                .result(true)
                .build();

        ObjectMapper objectMapper = new ObjectMapper();
        String jsonResponse = objectMapper.writeValueAsString(responseData);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse);
        response.getWriter().flush();

    }

    //로그인 실패시 실행하는 메소드
    @Override
    protected void unsuccessfulAuthentication(HttpServletRequest request, HttpServletResponse response, AuthenticationException failed) {
        response.setStatus(401);
    }

    private Cookie createCookie(String key, String value) {

        Cookie cookie = new Cookie(key, value);
        cookie.setMaxAge(60*60*60*60);
        //cookie.setSecure(true);
        cookie.setPath("/");
        cookie.setHttpOnly(false);

        return cookie;
    }

    @Builder
    @Getter
    public static class ResponseData{
        private String jwtAccess;
        private String jwtRefresh;
        private ResponseUserInfoData responseUserInfoData;
        private boolean result;
    }

    @Builder
    @Getter
    public static class ResponseUserInfoData{
        private Long id;
        private String nickname;
        private Long profilePetId;
        private int level;
        private int currency;
        private boolean isTutorial;
    }
}
