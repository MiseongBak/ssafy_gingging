package com.c206.backend.domain.plogging.exception;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum PloggingError {

    NOT_FOUND_PLOGGING(HttpStatus.INTERNAL_SERVER_ERROR, "해당 플로깅을 찾을 수 없습니다."),
    IMAGE_UPLOAD_ERROR(HttpStatus.BAD_REQUEST, "이미지 업로드 에러입니다."),
    TRASH_NOT_DETECTED(HttpStatus.BAD_REQUEST, "쓰레기가 확인 되지 않습니다."),
    FLASK_SERVER_ERROR(HttpStatus.BAD_REQUEST, "플라스크 서버 에러입니다.");


    private final HttpStatus httpStatus;
    private final String errorMessage;
}
