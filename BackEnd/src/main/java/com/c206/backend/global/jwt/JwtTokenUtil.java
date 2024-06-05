package com.c206.backend.global.jwt;


import io.jsonwebtoken.Jwts;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.util.Date;

@Component
public class JwtTokenUtil {

    private final SecretKey accessKey;
    private final SecretKey refreshKey;

    //      생성자. JWT secretKey 설정
    public JwtTokenUtil(@Value("${spring.jwt.access}")String access, @Value("${spring.jwt.refresh}")String refresh) {

        accessKey = new SecretKeySpec(access.getBytes(StandardCharsets.UTF_8), Jwts.SIG.HS256.key().build().getAlgorithm());
        refreshKey = new SecretKeySpec(refresh.getBytes(StandardCharsets.UTF_8), Jwts.SIG.HS256.key().build().getAlgorithm());
    }

    //    사용자 이름 반환
    public String getUsername(String token) {

        return Jwts.parser().verifyWith(accessKey).build().parseSignedClaims(token).getPayload().get("username", String.class);
    }

    //    사용자 멤버 아이디 반환
    public Long getMemberId(String token) {
        return Jwts.parser().verifyWith(accessKey).build().parseSignedClaims(token).getPayload().get("memberId", Long.class);
    }

    public Long getMemberIdRefresh(String token) {
        return Jwts.parser().verifyWith(refreshKey).build().parseSignedClaims(token).getPayload().get("memberId", Long.class);
    }


    //    사용자 닉네임 반환
    public String getNickname(String token) {

        return Jwts.parser().verifyWith(accessKey).build().parseSignedClaims(token).getPayload().get("nickname", String.class);
    }

    public String getNicknameRefresh(String token) {

        return Jwts.parser().verifyWith(refreshKey).build().parseSignedClaims(token).getPayload().get("nickname", String.class);
    }

    public String getEmail(String token){
        return Jwts.parser().verifyWith(accessKey).build().parseSignedClaims(token).getPayload().get("email", String.class);
    }

    public String getEmailRefresh(String token){
        return Jwts.parser().verifyWith(refreshKey).build().parseSignedClaims(token).getPayload().get("email", String.class);
    }

    public String getTokenType(String token){
        return Jwts.parser().verifyWith(accessKey).build().parseSignedClaims(token).getPayload().get("tokenType", String.class);
    }

    public String getTokenTypeRefresh(String token){
        return Jwts.parser().verifyWith(refreshKey).build().parseSignedClaims(token).getPayload().get("tokenType", String.class);
    }

    //    토큰 만료 여부 체크하기
    public Boolean isExpired(String token) {

        return Jwts.parser().verifyWith(accessKey).build().parseSignedClaims(token).getPayload().getExpiration().before(new Date());
    }

    //    토큰 만료 여부 체크하기
    public Boolean isExpiredRefresh(String token) {

        return Jwts.parser().verifyWith(refreshKey).build().parseSignedClaims(token).getPayload().getExpiration().before(new Date());
    }



    //    JWT 토큰발급
    public String createAccessJwt(Long memberId, String email, String nickname, Long expiredMs) {

        return Jwts.builder()
                .claim("tokenType", "access")
                .claim("memberId", memberId)
                .claim("email", email)
                .claim("nickname", nickname)
                .issuedAt(new Date(System.currentTimeMillis()))
                .expiration(new Date(System.currentTimeMillis() + expiredMs))
                .signWith(accessKey)
                .compact();
    }

    public String createRefreshJwt(Long memberId, String email, String nickname, Long expiredMs) {

        return Jwts.builder()
                .claim("tokenType", "refresh")
                .claim("memberId", memberId)
                .claim("email", email)
                .claim("nickname", nickname)
                .issuedAt(new Date(System.currentTimeMillis()))
                .expiration(new Date(System.currentTimeMillis() + expiredMs))
                .signWith(refreshKey)
                .compact();
    }
}
