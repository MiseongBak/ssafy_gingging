package com.c206.backend.domain.member.dto;

import com.c206.backend.domain.member.entity.Member;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor(access = AccessLevel.PUBLIC)
@AllArgsConstructor(access = AccessLevel.PUBLIC)
public class MemberDto {

    private Long memberId;
    private String email;
    private String nickname;
    private String password;

}
