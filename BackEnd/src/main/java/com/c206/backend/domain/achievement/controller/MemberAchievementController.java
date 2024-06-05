package com.c206.backend.domain.achievement.controller;


import com.c206.backend.domain.achievement.dto.response.MemberAchievementListResponseDto;
import com.c206.backend.domain.achievement.dto.response.NewGoalResponseDto;
import com.c206.backend.domain.achievement.service.MemberAchievementService;
import com.c206.backend.global.common.dto.Message;

import com.c206.backend.global.jwt.CustomUserDetails;
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
@RequestMapping("/api/v1/achievement")
public class MemberAchievementController {

    private final MemberAchievementService memberAchievementService;


    @GetMapping("/list")
    public ResponseEntity<Message<List<MemberAchievementListResponseDto>>> getMemberAchievementList(
            @Parameter(hidden = true) Authentication authentication) {
        CustomUserDetails customUserDetails = (CustomUserDetails) authentication.getPrincipal();
        Long memberId = customUserDetails.getId();
        List<MemberAchievementListResponseDto> memberAchievementListResponseDtoList = memberAchievementService.getMemberAchievementList(memberId);
        return ResponseEntity.ok().body(Message.success(memberAchievementListResponseDtoList));
    }



    @PostMapping("/{memberAchievementId}")
    public ResponseEntity<Message<NewGoalResponseDto>> receiveAchievementReward(
            @PathVariable("memberAchievementId") Long memberAchievementId,
            @Parameter(hidden = true) Authentication authentication) {
        CustomUserDetails customUserDetails = (CustomUserDetails) authentication.getPrincipal();
        Long memberId = customUserDetails.getId();
        NewGoalResponseDto newGoal = memberAchievementService.getReward(memberId, memberAchievementId);
        return ResponseEntity.ok().body(Message.success(newGoal));
    }
}
