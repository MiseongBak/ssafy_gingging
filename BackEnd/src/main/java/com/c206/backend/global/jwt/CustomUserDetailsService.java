package com.c206.backend.global.jwt;

import com.c206.backend.domain.member.dto.response.MemberInfoResponseDto;
import com.c206.backend.domain.member.entity.Member;
import com.c206.backend.domain.member.entity.MemberInfo;
import com.c206.backend.domain.member.repository.MemberInfoRepository;
import com.c206.backend.domain.member.repository.MemberRepository;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    private final MemberRepository memberRepository;

    private final MemberInfoRepository memberInfoRepository;

    public CustomUserDetailsService(MemberRepository memberRepository, MemberInfoRepository memberInfoRepository){
        this.memberRepository = memberRepository;
        this.memberInfoRepository = memberInfoRepository;
    }

    @Override
    public CustomUserDetails loadUserByUsername(String email) throws UsernameNotFoundException {

        System.out.println("여기는 CustomUserDetailsService");

        Optional<Member> member = memberRepository.findByEmail(email);
        if(member.isPresent()){
            //UserDetails에 담아서 return하면 AuthenticationManager가 검증 함
            System.out.println(member.get().getId());
            System.out.println(member.get().getEmail());
            System.out.println(member.get().getNickname());
            System.out.println(member.get().isTutorial());

            MemberInfo memberInfo = memberInfoRepository.findTopByMemberIdOrderByIdDesc(member.get().getId());

            MemberInfoResponseDto memberRes = MemberInfoResponseDto.builder()
                    .id(member.get().getId())
                    .email(member.get().getEmail())
                    .password(member.get().getPassword())
                    .nickname(member.get().getNickname())
                    .profilePetId(memberInfo.getProfilePetId())
                    .level(memberInfo.getExp()/1000)
                    .currency(memberInfo.getCurrency())
                    .isTutorial(member.get().isTutorial())
                    .build();
//            return new CustomUserDetails(member.get());
            return new CustomUserDetails(memberRes);
        }
        else{
            System.out.println("없는 회원입니다.");
            //에러처리하기
            return null;
        }

    }
}
