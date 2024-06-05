package com.c206.backend.domain.member.exception.member;

import lombok.Getter;

@Getter
public class MemberException extends RuntimeException {
    private final MemberError errorCode;
    private final int status;
    private final String errorMessage;

    public MemberException(MemberError errorCode) {
        super(errorCode.getErrorMessage());
        this.errorCode = errorCode;
        this.status = errorCode.getHttpStatus().value();
        this.errorMessage = errorCode.getErrorMessage();
    }
}
