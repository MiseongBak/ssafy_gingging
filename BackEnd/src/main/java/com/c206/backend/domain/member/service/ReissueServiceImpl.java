package com.c206.backend.domain.member.service;

import com.c206.backend.global.jwt.JwtTokenUtil;
import io.jsonwebtoken.ExpiredJwtException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class ReissueServiceImpl implements ReissueService {
//    @Value("${access.token.expiration.time}")
//    private Long accessExpireMs ;
//    @Value("${refresh.token.expiration.time}")
//    private Long refreshExpireMs ;
    private final JwtTokenUtil jwtTokenUtil;
    private final RedisService redisService;

    public ReissueServiceImpl(JwtTokenUtil jwtTokenUtil, RedisService redisService) {
        this.jwtTokenUtil = jwtTokenUtil;
        this.redisService = redisService;
    }

    @Override
    public ResponseEntity<?> reissueRefreshToken(HttpServletRequest request, HttpServletResponse response) {
        //refresh토큰 가져오기
        String refresh = null;
        Cookie[] cookies = request.getCookies();
        for (Cookie cookie : cookies) {
            log.info(cookie.getName() + " " + cookie.getValue());
            if (cookie.getName().equals("refresh")) {

                refresh = cookie.getValue();
            }
        }

        //refresh 토큰이 null이라면 에러발생
        if (refresh == null) {
            //response status code
            return new ResponseEntity<>("refresh token null", HttpStatus.BAD_REQUEST);
        }

        // refresh 토큰 만료 체크
        try {
            jwtTokenUtil.isExpiredRefresh(refresh);
        } catch (ExpiredJwtException e) {

            //response status code
            return new ResponseEntity<>("refresh token expired", HttpStatus.BAD_REQUEST);
        }

        // 토큰의 tokenType이 refresh인지 확인 (발급시 페이로드에 명시)
        String tokenType = jwtTokenUtil.getTokenTypeRefresh(refresh);
        System.out.println(tokenType);

        //만약 페이로드에 명시된 tokenType이 refresh가 아니라면
        if (!tokenType.equals("refresh")) {

            //response status code
            return new ResponseEntity<>("invalid refresh token", HttpStatus.BAD_REQUEST);
        }

        Long memberId = jwtTokenUtil.getMemberIdRefresh(refresh);
        String email = jwtTokenUtil.getEmailRefresh(refresh);
        String nickname = jwtTokenUtil.getNicknameRefresh(refresh);

        //redis DB에 저장되어 있는지 확인. 있다면 이 값은 redis 안에 있는 refresh 토큰 그 자체다
        String inRedisRefresh = redisService.getValues("refresh "+ email);

        //테스트
        boolean isExist = redisService.checkExistsValue(inRedisRefresh);
        if (!isExist) {
            //response body
            return new ResponseEntity<>("invalid refresh token", HttpStatus.BAD_REQUEST);
        }else if(!inRedisRefresh.equals(refresh)){
            return new ResponseEntity<>("invalid refresh token", HttpStatus.BAD_REQUEST);
        }

        //make new JWT
        String newAccess = jwtTokenUtil.createAccessJwt(memberId, email, nickname, (long) (14*60*60*1000));
        String newRefresh = jwtTokenUtil.createRefreshJwt(memberId, email, nickname, (long) (14*60*60*1000));

        //Refresh 토큰 저장 DB에 기존의 Refresh 토큰 삭제 후 새 Refresh 토큰 저장
        redisService.deleteValues("refresh "+ email);
        redisService.setValues("refresh "+ email, newRefresh, (long) (14*60*60*1000));

        //response
        response.setHeader("Authorization", "Bearer " + newAccess);
        response.addCookie(createCookie("Authorization", newAccess));
        response.addCookie(createCookie("refresh", newRefresh));

        return new ResponseEntity<>(HttpStatus.OK);
    }

    private Cookie createCookie(String key, String value) {

        Cookie cookie = new Cookie(key, value);
        cookie.setMaxAge(60*60*60*60);
        //cookie.setSecure(true);
        cookie.setPath("/");
        cookie.setHttpOnly(false);

        return cookie;
    }
}
