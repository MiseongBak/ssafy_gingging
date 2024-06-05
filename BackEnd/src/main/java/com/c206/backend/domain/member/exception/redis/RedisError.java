package com.c206.backend.domain.member.exception.redis;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum RedisError {

    FAIL_TO_SET_VALUE(HttpStatus.BAD_REQUEST, "값 저장에 실패했습니다."),
    FAIL_TO_GET_VALUE(HttpStatus.BAD_REQUEST, "값 불러오기에 실패했습니다."),
    FAIL_TO_DELETE_VALUE(HttpStatus.BAD_REQUEST, "값 삭제에 실패했습니다."),
    FAIL_TO_CHECK_IS_EXIST_VALUE(HttpStatus.BAD_REQUEST, "값 존재여부 확인에 실패했습니다.");

    private final HttpStatus httpStatus;
    private final String errorMessage;
}
