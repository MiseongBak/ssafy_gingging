package com.c206.backend.domain.ranking.dto.response;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import lombok.*;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class RankingListResponseDto {

    private String nickname;

    private int level;

    private int exp;

    private Long profilePetId;
}
