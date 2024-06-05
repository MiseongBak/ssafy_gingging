package com.c206.backend.domain.history.exception;

import lombok.Getter;

@Getter
public class HistoryException extends RuntimeException {
    private final HistoryError errorCode;
    private final int status;
    private final String errorMessage;

    public HistoryException(HistoryError errorCode) {
        super(errorCode.getErrorMessage());
        this.errorCode = errorCode;
        this.status = errorCode.getHttpStatus().value();
        this.errorMessage = errorCode.getErrorMessage();
    }
}
