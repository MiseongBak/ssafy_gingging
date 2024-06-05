package com.c206.backend.global.jwt;

import com.c206.backend.domain.member.dto.response.MemberInfoResponseDto;
import com.c206.backend.domain.member.entity.Member;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Component
public class JwtTokenFilter extends OncePerRequestFilter {

    // 예를 들어, 토큰 검증을 담당하는 JwtTokenUtil 컴포넌트를 주입받을 수 있습니다.
     private final JwtTokenUtil jwtTokenUtil;

    // 생성자 주입을 통한 JwtTokenUtil 컴포넌트의 주입
     public JwtTokenFilter(JwtTokenUtil jwtTokenUtil) {
         this.jwtTokenUtil = jwtTokenUtil;
     }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {
         //request 에서 Authorization 헤더 찾기
        String header = request.getHeader("Authorization");

        logger.info("filter  " + header);

        if(header == null || !header.startsWith("Bearer ")){
            System.out.println("token null");
            filterChain.doFilter(request, response);
            return;
        }

        //Bearer 부분 제거
        String token = header.split(" ")[1];

        if(jwtTokenUtil.isExpired(token)){
            System.out.println("token expired");
            filterChain.doFilter(request, response);

            return;
        }

        Long memberId = jwtTokenUtil.getMemberId(token);
        String email = jwtTokenUtil.getEmail(token);
        String nickname = jwtTokenUtil.getNickname(token);

        //...
        //userEntity를 생성하여 값 set
//        Member member = Member.builder()
//                .id(memberId)
//                .email(email)
//                .nickname(nickname)
//                .build();

        MemberInfoResponseDto member = MemberInfoResponseDto.builder()
                .id(memberId)
                .email(email)
                .nickname(nickname)
                .build();

        //UserDetails에 회원 정보 객체 담기
        CustomUserDetails customUserDetails = new CustomUserDetails(member);

//        System.out.println("여기는 JwtTokenFilter");
//        System.out.println("여기의 멤버 아이디는 "+ customUserDetails.getId());
//        System.out.println("여기의 이메일은 "+ customUserDetails.getEmail());
//        System.out.println("여기의 닉네임은 "+ customUserDetails.getNickname());

        //스프링 시큐리티 인증 토큰 생성
        Authentication authToken = new UsernamePasswordAuthenticationToken(customUserDetails,null, customUserDetails.getAuthorities());
//        System.out.println(authToken.getPrincipal()); // 이메일값 test01@gmail.com
//        System.out.println(authToken.getCredentials()); // 닉네임값 싸피맨
        //세션에 사용자 등록
        SecurityContextHolder.getContext().setAuthentication(authToken);

        // JWT 검증 로직 구현
        filterChain.doFilter(request, response);
    }
}
