package com.c206.backend.domain.notice.exception;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum NoticeError {

    FAIL_TO_FOUND_NOTICE(HttpStatus.INTERNAL_SERVER_ERROR, "해당 회원을 찾을 수 없습니다.");

    private final HttpStatus httpStatus;
    private final String errorMessage;
}
