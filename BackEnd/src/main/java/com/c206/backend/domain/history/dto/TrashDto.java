package com.c206.backend.domain.history.dto;

import com.c206.backend.domain.plogging.entity.enums.TrashType;
import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class TrashDto {
//    private Point Location;

    private double latitude;

    private double longitude;

    private TrashType type;

    private String image;
}
