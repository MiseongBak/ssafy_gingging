package com.c206.backend.global.exception;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

/**
 * 애플리케이션에서 발생할 수 있는 다양한 에러 상황을 정의한 열거형입니다.
 * 각 에러 코드는 HTTP 상태 코드와 에러 메시지를 가지고 있습니다.
 */
@Getter
@RequiredArgsConstructor
public enum GlobalError {
    NOT_AUTHORITY_MEMBER_API(HttpStatus.FORBIDDEN, "해당 API 호출에 대한 권한이 없습니다."),
    INVALID_TOKEN(HttpStatus.UNAUTHORIZED, "유효하지 않은 인증 토큰입니다."),
    CERTIFICATION_NOT_TOKEN(HttpStatus.UNAUTHORIZED, "자격 증명이 되어 있지 않은 토큰입니다."),
    FORBIDDEN_EXCEPTION(HttpStatus.FORBIDDEN, "권한이 없습니다."),
    AUTHENTICATION_EXCEPTION(HttpStatus.UNAUTHORIZED, "인증되지 않은 요청입니다."),
    MAXIMUM_UPLOAD_SIZE(HttpStatus.EXPECTATION_FAILED, "파일 크기가 최대 허용 크기를 초과했습니다."),
    REDIS_CONNECTION_FAILURE(HttpStatus.SERVICE_UNAVAILABLE, "Redis 연결에 실패했습니다."),
    DEFAULT_EXCEPTION(HttpStatus.BAD_REQUEST, "기본에러 입니다.");

    private final HttpStatus httpStatus; // 에러 상황에 해당하는 HTTP 상태 코드
    private final String errorMessage; // 에러 상황을 설명하는 메시지
}
