package com.c206.backend.domain.member.dto.response;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor(access = AccessLevel.PUBLIC)
@AllArgsConstructor(access = AccessLevel.PUBLIC)
public class MemberInfoResponseDto {

    private Long id;

    private String email;

    private String password;

    private String nickname;

    private Long profilePetId;

    private int level;

    private int currency;

    private boolean isTutorial;

}
