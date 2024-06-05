package com.c206.backend.domain.history.exception;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum HistoryError {

    NOT_FOUND_PLOGGING(HttpStatus.INTERNAL_SERVER_ERROR, "플로깅을 찾을 수 없습니다."),
    NOT_FOUND_MEMBER_PLOGGING(HttpStatus.INTERNAL_SERVER_ERROR, "해당 유저의 플로깅 히스토리가 아닙니다.");

    private final HttpStatus httpStatus;
    private final String errorMessage;
}
