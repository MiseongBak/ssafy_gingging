package com.c206.backend.domain.history.controller;


import com.c206.backend.domain.history.dto.response.HistoryDetailResponseDto;
import com.c206.backend.domain.history.dto.response.HistoryListResponseDto;
import com.c206.backend.domain.history.service.HistoryService;
import com.c206.backend.global.common.dto.Message;
import com.c206.backend.global.jwt.CustomUserDetails;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/history")
public class HistoryController {

    private final HistoryService historyService;

    @GetMapping("/list")
    @Operation(summary = "히스토리 목록을 반환합니다.")
    public ResponseEntity<Message<List<HistoryListResponseDto>>> historyList(@Parameter(hidden = true)Authentication authentication){
        CustomUserDetails customUserDetails = (CustomUserDetails) authentication.getPrincipal();
        Long memberId = customUserDetails.getId();

        List<HistoryListResponseDto> historyList = historyService.historyList(memberId);

        return ResponseEntity.ok().body(Message.success(historyList));
    }


    @GetMapping("/detail/{ploggingId}")
    @Operation(summary = "히스토리 디테일을 반환합니다.")
    public ResponseEntity<Message<HistoryDetailResponseDto>> historyDetail(@Parameter(hidden = true)Authentication authentication, @PathVariable("ploggingId") Long ploggingId){

        CustomUserDetails customUserDetails = (CustomUserDetails) authentication.getPrincipal();
        Long memberId = customUserDetails.getId();

        HistoryDetailResponseDto historyDetailResponseDTO = historyService.historyDetail(memberId, ploggingId);

        return ResponseEntity.ok().body(Message.success(historyDetailResponseDTO));
    }

}
