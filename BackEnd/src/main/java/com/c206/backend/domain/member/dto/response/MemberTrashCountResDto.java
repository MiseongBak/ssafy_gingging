package com.c206.backend.domain.member.dto.response;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor(access = AccessLevel.PUBLIC)
@AllArgsConstructor(access = AccessLevel.PUBLIC)
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class MemberTrashCountResDto {

    private String email;

    private String nickname;

    private Long profilePetId;

    private int level;

    private int currency;

    private int trashNormal;

    private int trashPlastic;

    private int trashCan;

    private int trashGlass;
}
