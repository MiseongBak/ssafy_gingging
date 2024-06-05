package com.c206.backend.domain.quest.controller;

import com.c206.backend.domain.quest.dto.response.MemberQuestListResponseDto;
import com.c206.backend.domain.quest.service.MemberQuestService;
import com.c206.backend.global.common.dto.Message;
import com.c206.backend.global.jwt.CustomUserDetails;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/quest")
public class MemberQuestController {

    private final MemberQuestService memberQuestService;

    @GetMapping(value = "/list")
    @Operation(summary = "퀘스트 목록을 열람합니다.")
    public ResponseEntity<Message<List<MemberQuestListResponseDto>>> questList(@Parameter(hidden = true)Authentication authentication){
        CustomUserDetails customUserDetails = (CustomUserDetails) authentication.getPrincipal();
        Long memberId = customUserDetails.getId();

        List<MemberQuestListResponseDto> questList = memberQuestService.getQuestList(memberId);
        return ResponseEntity.ok().body(Message.success(questList));
    }

    @PostMapping(value = "/{memberQuestId}")
    @Operation(summary = "퀘스트 보상을 지급합니다.")
    public ResponseEntity<Message<Integer>> questReward(@Parameter(hidden = true)Authentication authentication,
                                                  @PathVariable(value = "memberQuestId") Long memberQuestId ){
        CustomUserDetails customUserDetails = (CustomUserDetails) authentication.getPrincipal();
        Long memberId = customUserDetails.getId();

        Integer reward = memberQuestService.getQuestReward(memberId, memberQuestId);
        return ResponseEntity.ok().body(Message.success(reward));
    }

    @PostMapping(value = "addquest")
    @Operation(summary = " 테스트용 API.사용자에게 퀘스트를 생성해줍니다.")
    public ResponseEntity<Message<Void>> addQuest(@Parameter(hidden = true)Authentication authentication){
        CustomUserDetails customUserDetails = (CustomUserDetails) authentication.getPrincipal();
        Long memberId = customUserDetails.getId();
        memberQuestService.addQuestList(memberId);
        return ResponseEntity.ok().body(Message.success());
    }

}
