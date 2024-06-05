package com.c206.backend.domain.pet.dto.response;

import com.c206.backend.domain.pet.entity.enums.PetType;
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
public class PetListResponseDto {

    private Long petId;

    private String image;

    private String name;

    private PetType petType;

    private boolean isHave;

    private boolean isActive;

}
