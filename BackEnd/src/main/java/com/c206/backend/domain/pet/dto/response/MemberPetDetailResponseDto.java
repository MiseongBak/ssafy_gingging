package com.c206.backend.domain.pet.dto.response;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class MemberPetDetailResponseDto {

    private String nickname;

    private boolean active;

    private int exp;

    private String image;

    private int normal;

    private int plastic;

    private int can;

    private int glass;

}
