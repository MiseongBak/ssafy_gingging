package com.c206.backend.domain.quest.exception;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum MemberQuestError {

    NOT_FOUND_MEMBER_QUEST(HttpStatus.INTERNAL_SERVER_ERROR, "해당 퀘스트를 찾을 수 없습니다."),
    QUEST_NOT_COMPLETED(HttpStatus.BAD_REQUEST, "퀘스트를 완료하지 못한 상태입니다."),
    NOT_MATCH_QUEST(HttpStatus.BAD_REQUEST, "로그인한 회원의 퀘스트가 아닙니다.");

    private final HttpStatus httpStatus;
    private final String errorMessage;
}
