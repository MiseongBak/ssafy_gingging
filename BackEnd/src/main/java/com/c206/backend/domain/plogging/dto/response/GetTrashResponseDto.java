package com.c206.backend.domain.plogging.dto.response;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class GetTrashResponseDto {

    private int normal;
    private int plastic;
    private int can;
    private int glass;

}
