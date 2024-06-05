package com.c206.backend.domain.quest.exception;

import lombok.Getter;

@Getter
public class MemberQuestException extends RuntimeException {
    private final MemberQuestError errorCode;
    private final int status;
    private final String errorMessage;

    public MemberQuestException(MemberQuestError errorCode) {
        super(errorCode.getErrorMessage());
        this.errorCode = errorCode;
        this.status = errorCode.getHttpStatus().value();
        this.errorMessage = errorCode.getErrorMessage();
    }
}
