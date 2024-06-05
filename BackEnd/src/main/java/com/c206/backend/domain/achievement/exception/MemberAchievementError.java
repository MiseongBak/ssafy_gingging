package com.c206.backend.domain.achievement.exception;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum MemberAchievementError {

    NOT_FOUND_MEMBER_ACHIEVEMENT(HttpStatus.INTERNAL_SERVER_ERROR, "해당 업적을 찾을 수 없습니다."),
    ACHIEVEMENT_NOT_COMPLETED(HttpStatus.BAD_REQUEST, "업적을 완료하지 못한 상태입니다."),
    NOT_MATCH_ACHIEVEMENT(HttpStatus.BAD_REQUEST, "로그인한 회원의 업적이 아닙니다.");

    private final HttpStatus httpStatus;
    private final String errorMessage;
}
