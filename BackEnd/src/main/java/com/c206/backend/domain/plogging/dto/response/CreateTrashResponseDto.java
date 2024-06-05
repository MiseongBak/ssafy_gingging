package com.c206.backend.domain.plogging.dto.response;



import com.c206.backend.domain.plogging.entity.enums.TrashType;
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
public class CreateTrashResponseDto {

    private TrashType trashType;

    private int value;

    private boolean petActive;

    private boolean isRescue;

}
