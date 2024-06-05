package com.c206.backend.domain.plogging.dto.request;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CreateTrashRequestDto {

    // 바이트로 들어온다 변경 필수
    private byte[] image;

    private double latitude;

    private double longitude;

}
