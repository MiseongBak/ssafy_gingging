package com.c206.backend.domain.plogging.service;

import com.c206.backend.domain.plogging.dto.LocationInfo;
import com.c206.backend.domain.plogging.dto.request.CreateTrashRequestDto;
import com.c206.backend.domain.plogging.dto.request.GetTrashRequestDto;
import com.c206.backend.domain.plogging.dto.response.CreateTrashResponseDto;
import com.c206.backend.domain.plogging.dto.response.GetTrashResponseDto;

import java.util.concurrent.CompletableFuture;

public interface TrashService {

    CreateTrashResponseDto createTrash(Long ploggingId, CreateTrashRequestDto createTrashRequestDto);

    CreateTrashResponseDto createTrashTest(Long ploggingId, LocationInfo locationInfo);

    GetTrashResponseDto getTrashList(GetTrashRequestDto getTrashRequestDto);

}
