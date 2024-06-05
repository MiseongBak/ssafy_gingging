package com.c206.backend.domain.ranking.controller;

import com.c206.backend.domain.ranking.dto.response.RankingListResponseDto;
import com.c206.backend.domain.ranking.service.RankingService;
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
@RequestMapping("/api/v1/ranking")
public class RankingController {

    private final RankingService rankingService;

    @GetMapping()
    @Operation(summary = "상위 10명의 랭킹을 조회합니다")
    public ResponseEntity<Message<List<RankingListResponseDto>>> getRankingList(@Parameter(hidden = true)Authentication authentication){
        List<RankingListResponseDto> rankingList = rankingService.rankingList();

        return ResponseEntity.ok().body(Message.success(rankingList));
    }
}
