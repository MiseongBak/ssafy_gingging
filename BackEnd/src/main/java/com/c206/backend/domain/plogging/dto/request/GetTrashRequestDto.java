package com.c206.backend.domain.plogging.dto.request;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class GetTrashRequestDto {

    private double latitude;

    private double longitude;

    private int radius;
}
