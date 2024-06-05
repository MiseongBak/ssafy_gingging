package com.c206.backend.domain.member.exception.redis;

import lombok.Getter;

@Getter
public class RedisException extends RuntimeException {
    private final RedisError errorCode;
    private final int status;
    private final String errorMessage;

    public RedisException(RedisError errorCode) {
        super(errorCode.getErrorMessage());
        this.errorCode = errorCode;
        this.status = errorCode.getHttpStatus().value();
        this.errorMessage = errorCode.getErrorMessage();
    }
}
