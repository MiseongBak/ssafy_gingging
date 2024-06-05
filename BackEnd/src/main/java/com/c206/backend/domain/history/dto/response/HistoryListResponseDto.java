package com.c206.backend.domain.history.dto.response;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class HistoryListResponseDto {

    private Long ploggingId;

    private LocalDateTime createAt;

    private LocalDateTime updateAt;

    private Long petId;

    private int distance;

    private int trashCount;

}
