package com.c206.backend.domain.plogging.controller;

import com.c206.backend.domain.plogging.dto.LocationInfo;
import com.c206.backend.domain.plogging.dto.request.CreateTrashRequestDto;
import com.c206.backend.domain.plogging.dto.request.FinishPloggingRequestDto;
import com.c206.backend.domain.plogging.dto.request.GetTrashRequestDto;
import com.c206.backend.domain.plogging.dto.response.CreateTrashResponseDto;
import com.c206.backend.domain.plogging.dto.response.FinishPloggingResponseDto;
import com.c206.backend.domain.plogging.dto.response.GetTrashResponseDto;
import com.c206.backend.domain.plogging.service.PloggingService;
import com.c206.backend.domain.plogging.service.TrashService;
import com.c206.backend.global.common.dto.Message;
import com.c206.backend.global.jwt.CustomUserDetails;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.concurrent.CompletableFuture;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/plogging")
@Tag(name = "Plogging", description = "Plogging API")
public class PloggingController {

    private final PloggingService ploggingService;
    private final TrashService trashService;


    @PostMapping("/start/{memberPetId}")
    public ResponseEntity<Message<Long>> createPlogging(
            @PathVariable("memberPetId") Long memberPetId,
            @Parameter(hidden = true) Authentication authentication) {
        CustomUserDetails customUserDetails = (CustomUserDetails) authentication.getPrincipal();
        Long memberId = customUserDetails.getId();
        Long ploggingId = ploggingService.createPlogging(memberPetId, memberId);
        return ResponseEntity.ok().body(Message.success(ploggingId));
    }


    @PostMapping("/trash/{ploggingId}")
    public ResponseEntity<Message<CreateTrashResponseDto>> createTrash(
            @PathVariable("ploggingId") Long ploggingId,
            @RequestBody CreateTrashRequestDto createTrashRequestDto) {
        CreateTrashResponseDto createTrashResponseDto = trashService.createTrash(ploggingId,createTrashRequestDto);
        return ResponseEntity.ok().body(Message.success(createTrashResponseDto));
    }

    // 쓰레기 줍기 테스트용
    @PostMapping("/trash/test/{ploggingId}")
    public ResponseEntity<Message<CreateTrashResponseDto>> createTrashTest(
            @PathVariable("ploggingId") Long ploggingId,
            @RequestBody LocationInfo locationInfo) {
        CreateTrashResponseDto createTrashResponseDto = trashService.createTrashTest(ploggingId,locationInfo);
        return ResponseEntity.ok().body(Message.success(createTrashResponseDto));
    }

    @PostMapping("/trash/list")
    public ResponseEntity<Message<GetTrashResponseDto>> getTrashList(
            @RequestBody GetTrashRequestDto getTrashRequestDto) {
        GetTrashResponseDto getTrashResponseDto = trashService.getTrashList(getTrashRequestDto);
        return ResponseEntity.ok().body(Message.success(getTrashResponseDto));
    }

    @PostMapping("/finish/{ploggingId}")
    public ResponseEntity<Message<FinishPloggingResponseDto>> finishPlogging(
            @PathVariable("ploggingId") Long ploggingId,
            @RequestBody FinishPloggingRequestDto finishPloggingRequestDto) {
        FinishPloggingResponseDto finishPloggingResponseDto = ploggingService.finishPlogging(ploggingId, finishPloggingRequestDto);
        return ResponseEntity.ok().body(Message.success(finishPloggingResponseDto));
    }
}
