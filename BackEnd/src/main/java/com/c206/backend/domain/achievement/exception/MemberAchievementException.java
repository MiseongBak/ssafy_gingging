package com.c206.backend.domain.achievement.exception;

import lombok.Getter;

@Getter
public class MemberAchievementException extends RuntimeException {
    private final MemberAchievementError errorCode;
    private final int status;
    private final String errorMessage;

    public MemberAchievementException(MemberAchievementError errorCode) {
        super(errorCode.getErrorMessage());
        this.errorCode = errorCode;
        this.status = errorCode.getHttpStatus().value();
        this.errorMessage = errorCode.getErrorMessage();
    }
}
