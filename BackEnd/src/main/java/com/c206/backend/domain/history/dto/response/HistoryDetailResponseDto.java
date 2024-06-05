package com.c206.backend.domain.history.dto.response;


import com.c206.backend.domain.history.dto.RouteDto;
import com.c206.backend.domain.history.dto.TrashDto;
import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class HistoryDetailResponseDto {

    private Long ploggingId;

    private List<TrashDto> trashList;

    private List<RouteDto> routeList;

    private int normalTrashCount;

    private int plasticTrashCount;

    private int canTrashCount;

    private int glassTrashCount;

}
