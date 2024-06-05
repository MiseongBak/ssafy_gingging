package com.c206.backend.domain.plogging.dto.request;

import com.c206.backend.domain.plogging.dto.LocationInfo;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class FinishPloggingRequestDto {

    private List<LocationInfo> path;

    private int distance;


}
