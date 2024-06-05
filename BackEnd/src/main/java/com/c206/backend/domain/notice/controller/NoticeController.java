package com.c206.backend.domain.notice.controller;

import com.c206.backend.domain.notice.dto.response.NoticeListResponseDto;
import com.c206.backend.domain.notice.service.NoticeService;
import com.c206.backend.global.common.dto.Message;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/notice")
public class NoticeController {

    private final NoticeService noticeService;

    @GetMapping("/list")
    @Operation(summary = "(공지사항)플로깅 정보 목록을 열람합니다.")
    public ResponseEntity<Message<List<NoticeListResponseDto>>> getMemberPetList(
            @Parameter(hidden = true) Authentication authentication) {

        List<NoticeListResponseDto> noticeList = noticeService.noticeList();

        return ResponseEntity.ok().body(Message.success(noticeList));
    }
}
