package com.c206.backend.domain.plogging.service;

import com.c206.backend.domain.plogging.dto.request.FinishPloggingRequestDto;
import com.c206.backend.domain.plogging.dto.response.FinishPloggingResponseDto;


public interface PloggingService {
    Long createPlogging(Long memberPetId, Long memberId);

    FinishPloggingResponseDto finishPlogging(Long ploggingId, FinishPloggingRequestDto finishPloggingRequestDto);
}
