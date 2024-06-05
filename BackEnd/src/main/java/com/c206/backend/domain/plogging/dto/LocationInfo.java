package com.c206.backend.domain.plogging.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class LocationInfo {
    private double latitude;

    private double longitude;
}
